# gomazarashi.github.io

個人用ウェブサイトのリポジトリです。  
Typst / Tola を使って静的サイトを生成し、GitHub Pages で公開する前提です。

## 使用技術

- Typst
- Tola
- Nix (`nix develop`)
- just
- GitHub Pages

## 初回セットアップ

1. リポジトリをクローンする。
2. 開発シェルに入る。

```bash
nix develop
```

3. ツールが揃っているか確認する。

```bash
just doctor
```

## よく使うコマンド

```bash
just build
```

- サイトをビルドする（出力: `public/`）。

```bash
just serve
```

- ローカル開発サーバーを起動する。

```bash
just rebuild
```

- `public/` と `.tola/` を削除してから再生成する。

## ディレクトリ運用

- `public/` はビルド成果物の出力先。
- `.tola/` は Tola の内部作業ディレクトリ。
- `public/` と `.tola/` は Git 管理しない運用（`.gitignore` 設定済み）。

## 記事ファイル命名規則

`content/posts/` 配下の記事は、以下の形式で作成する。

`yyyymmdd-slug.typ`

例: `20260412-first-post.typ`
