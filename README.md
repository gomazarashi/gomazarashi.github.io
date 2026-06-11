# gomazarashi.github.io

個人用ウェブサイトのリポジトリです。  
Typst / Tola を使って静的サイトを生成し、GitHub Pages で公開する前提です。

公開中のサイト:

https://gomazarashi.com/

## 開発環境

- Typst 0.14.2
- Tola 0.7.1
- just 1.52.0
- GitHub Pages

## 初回セットアップ

1. リポジトリをクローンする。
2. `typst`、`tola`、`just` をインストールする。
3. 必要なコマンドが揃っているか確認する。

各コマンドの導入方法は以下を参照する。

- `typst`: <https://github.com/typst/typst> から 0.14.2 を導入する
- `tola`: Rust/Cargo 環境がある場合は `cargo install --locked tola --version 0.7.1`
- `just`: <https://just.systems/> から 1.52.0 を導入する

```bash
just doctor
```

## よく使うコマンド

```bash
just build
```

- サイトをビルドする（出力: `docs/`）。

```bash
just serve
```

- ローカル開発サーバーを起動する。

```bash
just rebuild
```

- `docs/` と `.tola/` を削除してから再生成する。

## ディレクトリ運用

- `docs/` はビルド成果物の出力先。
- `.tola/` は Tola の内部作業ディレクトリ。
- `docs/` は Git 管理し、`just build` で更新してから commit / push する。
- GitHub Pages は `Deploy from a branch` を選び、公開元を `main` ブランチの `/docs` に設定する。
- `public/` は旧ビルド出力先として不要だが、誤生成された場合に備えて引き続き Git 管理しない。
- `.tola/` は Git 管理しない運用（`.gitignore` 設定済み）。

## 記事ファイル命名規則

`content/posts/` 配下の記事は、以下の形式で作成する。

`yyyymmdd-slug.typ`

例: `20260412-first-post.typ`
