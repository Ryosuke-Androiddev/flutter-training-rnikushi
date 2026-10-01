# CLAUDE.md

## プロジェクト概要

ゆめみの Flutter 研修（[flutter-training-template](https://github.com/yumemi-inc/flutter-training-template)）の課題用リポジトリ。課題は Issue（Session0, Session1, ...）単位で進める。

## 開発環境

- Flutter SDK は fvm で管理する（バージョンは `.fvmrc` を参照）
- Flutter / Dart のコマンドは必ず `fvm` 経由で実行する

```sh
fvm install            # .fvmrc のバージョンをインストール
fvm flutter pub get
fvm flutter analyze
fvm flutter test
fvm flutter run -d <device>
```

## コーディング規約

- 静的解析は `yumemi_lints`（`analysis_options.yaml`）に従う
- CI では info レベルの指摘も失敗扱いになるため、`fvm flutter analyze` で指摘ゼロを保つ

## ブランチ・PR 運用

- `main` への直接 push は不可。作業ブランチを切り、PR 経由でマージする
- マージ条件: ステータスチェック `check` / `flutter test` の成功、ブランチが最新、会話がすべて解決済み、署名付きコミット
- マージ後のヘッドブランチは自動削除される

## レビュー

- レビューコメントは日本語で行う
- 研修の課題であるため、Issue に書かれた課題の要件を満たしているかも確認する
