#!/usr/bin/env python3
import argparse
import base64
import json
import re
import subprocess
import sys
import time
from pathlib import Path

ASSETS_BRANCH = "pr-assets"
PLATFORMS = ["ios", "android"]
PHASES = ["before", "after"]
SECTION_HEADING = "## UIの変更"


def run(cmd, *, input_text=None, check=True, capture=True):
    result = subprocess.run(
        cmd,
        input=input_text,
        text=True,
        capture_output=capture,
    )
    if check and result.returncode != 0:
        sys.exit(f"command failed: {' '.join(cmd)}\n{result.stderr}")
    return result.stdout.strip() if capture else ""


def project_root():
    return Path(run(["git", "rev-parse", "--show-toplevel"]))


def booted_ios_udid():
    out = run(["xcrun", "simctl", "list", "devices", "booted", "-j"], check=False)
    if not out:
        return None
    for devices in json.loads(out).get("devices", {}).values():
        for device in devices:
            if device.get("state") == "Booted":
                return device["udid"]
    return None


def android_serial():
    out = run(["adb", "devices"], check=False)
    for line in out.splitlines()[1:]:
        parts = line.split()
        if len(parts) == 2 and parts[1] == "device":
            return parts[0]
    return None


def detect_devices(requested):
    devices = {}
    if "ios" in requested:
        udid = booted_ios_udid()
        if udid:
            devices["ios"] = udid
        else:
            print("skip ios: no booted simulator")
    if "android" in requested:
        serial = android_serial()
        if serial:
            devices["android"] = serial
        else:
            print("skip android: no running emulator")
    if not devices:
        sys.exit("no running simulator or emulator found")
    return devices


def android_application_id(root):
    for name in ["build.gradle.kts", "build.gradle"]:
        path = root / "android" / "app" / name
        if path.exists():
            match = re.search(r'applicationId\s*=?\s*"([^"]+)"', path.read_text())
            if match:
                return match.group(1)
    sys.exit("applicationId not found")


def ios_bundle_id(root):
    text = (root / "ios" / "Runner.xcodeproj" / "project.pbxproj").read_text()
    for value in re.findall(r"PRODUCT_BUNDLE_IDENTIFIER = ([^;]+);", text):
        if "RunnerTests" not in value:
            return value.strip('"')
    sys.exit("PRODUCT_BUNDLE_IDENTIFIER not found")


def image_path(out_dir, prefix, phase, platform):
    return Path(out_dir).expanduser() / f"{prefix}_{phase}_{platform}.png"


def capture(args):
    devices = detect_devices(args.platforms)
    for platform, device in devices.items():
        dest = image_path(args.out_dir, args.prefix, args.phase, platform)
        dest.parent.mkdir(parents=True, exist_ok=True)
        if platform == "ios":
            run(["xcrun", "simctl", "io", device, "screenshot", str(dest)])
        else:
            remote = "/sdcard/pr_screenshot.png"
            run(["adb", "-s", device, "shell", "screencap", "-p", remote])
            run(["adb", "-s", device, "pull", remote, str(dest)])
            run(["adb", "-s", device, "shell", "rm", remote])
        if dest.read_bytes()[:8] != b"\x89PNG\r\n\x1a\n":
            sys.exit(f"invalid png: {dest}")
        print(f"saved {platform}: {dest}")


def launch(args):
    root = project_root()
    devices = detect_devices(args.platforms)
    flutter = ["fvm", "flutter"]
    if "android" in devices:
        serial = devices["android"]
        app_id = android_application_id(root)
        if not args.no_build:
            run(flutter + ["build", "apk", "--debug"], capture=False)
            apk = root / "build" / "app" / "outputs" / "flutter-apk" / "app-debug.apk"
            run(["adb", "-s", serial, "install", "-r", str(apk)])
        run(["adb", "-s", serial, "shell", "am", "force-stop", app_id])
        run(["adb", "-s", serial, "shell", "monkey", "-p", app_id,
             "-c", "android.intent.category.LAUNCHER", "1"])
        print(f"launched android: {app_id}")
    if "ios" in devices:
        udid = devices["ios"]
        bundle_id = ios_bundle_id(root)
        if not args.no_build:
            run(flutter + ["build", "ios", "--simulator", "--debug"], capture=False)
            app = root / "build" / "ios" / "iphonesimulator" / "Runner.app"
            run(["xcrun", "simctl", "install", udid, str(app)])
        run(["xcrun", "simctl", "terminate", udid, bundle_id], check=False)
        run(["xcrun", "simctl", "launch", udid, bundle_id])
        print(f"launched ios: {bundle_id}")
    time.sleep(args.wait)


def gh_api(path, *, method="GET", payload=None, jq=None):
    cmd = ["gh", "api", path, "--method", method]
    if jq:
        cmd += ["--jq", jq]
    if payload is not None:
        cmd += ["--input", "-"]
    return run(cmd, input_text=json.dumps(payload) if payload is not None else None)


def upload_images(repo, files):
    head = run(["gh", "api", f"repos/{repo}/git/ref/heads/{ASSETS_BRANCH}",
                "--jq", ".object.sha"], check=False)
    tree = []
    for remote_path, local in files.items():
        content = base64.b64encode(local.read_bytes()).decode()
        sha = gh_api(f"repos/{repo}/git/blobs", method="POST",
                     payload={"encoding": "base64", "content": content}, jq=".sha")
        tree.append({"path": remote_path, "mode": "100644", "type": "blob", "sha": sha})
    tree_payload = {"tree": tree}
    if head:
        tree_payload["base_tree"] = gh_api(f"repos/{repo}/git/commits/{head}", jq=".tree.sha")
    tree_sha = gh_api(f"repos/{repo}/git/trees", method="POST", payload=tree_payload, jq=".sha")
    commit_payload = {
        "message": f"Add PR screenshots: {', '.join(files)}",
        "tree": tree_sha,
        "parents": [head] if head else [],
    }
    commit_sha = gh_api(f"repos/{repo}/git/commits", method="POST",
                        payload=commit_payload, jq=".sha")
    if head:
        gh_api(f"repos/{repo}/git/refs/heads/{ASSETS_BRANCH}", method="PATCH",
               payload={"sha": commit_sha})
    else:
        gh_api(f"repos/{repo}/git/refs", method="POST",
               payload={"ref": f"refs/heads/{ASSETS_BRANCH}", "sha": commit_sha})
    return commit_sha


def build_section(repo, commit_sha, prefix, platforms, labels):
    lines = [SECTION_HEADING, ""]
    if len(platforms) == 2:
        lines.append(f"上段: {labels[platforms[0]]}、下段: {labels[platforms[1]]}")
    else:
        lines.append(labels[platforms[0]])
    lines += ["", "| Before | After |", "| :---: | :---: |"]
    for platform in platforms:
        cells = []
        for phase in PHASES:
            url = f"https://github.com/{repo}/blob/{commit_sha}/{prefix}/{phase}_{platform}.png?raw=true"
            cells.append(f'<img src="{url}" width="200">')
        lines.append(f"| {cells[0]} | {cells[1]} |")
    return "\n".join(lines)


def replace_section(body, section):
    lines = body.splitlines()
    start = next((i for i, line in enumerate(lines) if line.strip() == SECTION_HEADING), None)
    if start is None:
        footer = next((i for i, line in enumerate(lines) if line.startswith("🤖 Generated")), None)
        if footer is None:
            return body.rstrip() + "\n\n" + section + "\n"
        return "\n".join(lines[:footer]).rstrip() + "\n\n" + section + "\n\n" + "\n".join(lines[footer:]) + "\n"
    end = len(lines)
    for i in range(start + 1, len(lines)):
        if lines[i].startswith("## ") or lines[i].startswith("🤖 Generated"):
            end = i
            break
    head = "\n".join(lines[:start]).rstrip()
    rest = "\n".join(lines[end:])
    return (head + "\n\n" if head else "") + section + ("\n\n" + rest if rest else "") + "\n"


def attach(args):
    repo = run(["gh", "repo", "view", "--json", "nameWithOwner", "--jq", ".nameWithOwner"])
    pr = args.pr or run(["gh", "pr", "view", "--json", "number", "--jq", ".number"])
    platforms = [
        p for p in args.platforms
        if all(image_path(args.out_dir, args.prefix, phase, p).exists() for phase in PHASES)
    ]
    if not platforms:
        sys.exit("no before/after pair found")
    files = {
        f"{args.prefix}/{phase}_{platform}.png": image_path(args.out_dir, args.prefix, phase, platform)
        for platform in platforms
        for phase in PHASES
    }
    commit_sha = upload_images(repo, files)
    labels = {"ios": args.ios_label, "android": args.android_label}
    section = build_section(repo, commit_sha, args.prefix, platforms, labels)
    body = run(["gh", "pr", "view", str(pr), "--json", "body", "--jq", ".body"])
    run(["gh", "pr", "edit", str(pr), "--body-file", "-"], input_text=replace_section(body, section))
    print(f"attached {', '.join(platforms)} to PR #{pr} (assets commit {commit_sha})")
    print(run(["gh", "pr", "view", str(pr), "--json", "url", "--jq", ".url"]))


def main():
    parser = argparse.ArgumentParser()
    sub = parser.add_subparsers(dest="command", required=True)

    def common(p):
        p.add_argument("--prefix", required=True)
        p.add_argument("--out-dir", default="~/Desktop")
        p.add_argument("--platforms", nargs="+", choices=PLATFORMS, default=PLATFORMS)

    p_capture = sub.add_parser("capture")
    common(p_capture)
    p_capture.add_argument("--phase", choices=PHASES, required=True)
    p_capture.set_defaults(func=capture)

    p_launch = sub.add_parser("launch")
    p_launch.add_argument("--platforms", nargs="+", choices=PLATFORMS, default=PLATFORMS)
    p_launch.add_argument("--no-build", action="store_true")
    p_launch.add_argument("--wait", type=float, default=4)
    p_launch.set_defaults(func=launch)

    p_attach = sub.add_parser("attach")
    common(p_attach)
    p_attach.add_argument("--pr")
    p_attach.add_argument("--ios-label", default="iOS（Simulator）")
    p_attach.add_argument("--android-label", default="Android（Emulator）")
    p_attach.set_defaults(func=attach)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
