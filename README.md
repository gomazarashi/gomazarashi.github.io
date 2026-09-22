# gomazarashi.github.io

個人用ウェブサイトのリポジトリです。  
Typst / Tola を使って静的サイトを生成し、GitHub Pages で公開する前提です。

公開中のサイト:

https://gomazarashi.com/

## 開発環境

- Typst 0.14.2
- Tola 0.7.1
- just 1.52.0
- Python 3.11+（OG画像のbuild補助。標準ライブラリのみ使用）
- GitHub Pages

OG画像の生成には次の日本語フォントが必要です（リポジトリには同梱しません）。

- Noto Sans JP（第一候補）
- Noto Sans CJK JP（第二候補）

どちらも `typst fonts` から見つからない場合、`just og` / `just build` は明示的に失敗します。
OS標準フォントへはフォールバックしません。

`scripts/og_common.py` にドキュメント上のツールバージョン（Typst 0.14.2 / Tola 0.7.1）を
記録しています。実際のバージョンと異なる場合、`just doctor` は `mismatch` を表示し、
`just og` / `just build` は警告を出します（buildは継続します）。

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
- OG画像の生成 → `docs/images/og/` の掃除 → `tola build --skip-drafts` →
  sitemap修正 → OG/HTML validation → CNAME確認、までを実行する。

```bash
just og
```

- OG画像（`assets/images/og/`）だけを再生成する。
- 記事の title / summary / date / tags などを変更した後に実行する。

```bash
just validate-og
```

- 生成済み `docs/` に対してOG metadataとPNGを検証する（build後のみ）。

```bash
just test-og
```

- OGテンプレートのfixtureテスト。一時JSONからPNGを生成し、タイトル折り返し・
  タグの省略・長いトークン・オーバーフロー失敗系を検証する。
  公開contentや `docs/` には書き込まない。

```bash
just serve
```

- ローカル開発サーバーを起動する。起動前にdraft込みのOG画像を一度生成する。

```bash
just rebuild
```

- `docs/` と `.tola/` を削除してから再生成する。

## OG画像とOGP metadata

### アーキテクチャ

```text
content/posts/*.typ の metadata
        ↓ Tola 標準の <tola-meta>
tola query（JSON: .og/posts.json）
        ↓ Python 3 standard library
og/*.typ（Typst, 1200x630, 144 ppi）
        ↓
assets/images/og/（Git管理しない一時生成物）
        ↓ Tola の nested assets
docs/images/og/（公開artifact。Git管理する）
        ↓ GitHub Pages
https://gomazarashi.com/images/og/...
```

- 記事metadataの single source of truth は `content/posts/*.typ`。
- OG画像用にmetadataを別ファイルへ手入力しない。
- 記事metadataの抽出は `tola query` を使用し、独自parserは使わない。
- 記事一覧（`/posts/`）とトップの最新記事は `@tola/pages` から生成し、
  一覧側へtitle / date / summaryを手入力しない。
- HTML側のOGPは `utils/meta.typ` に集約している。

### 公開URL

| 対象 | URL |
| --- | --- |
| 固定ページ共通 | `/images/og/default.png` |
| 記事 | `/images/og/posts/<source-stem>.png` |

`<source-stem>` は `content/posts` 配下のsource filenameから拡張子を除いたもの
（例: `content/posts/20260412-first-post.typ` → `20260412-first-post`）。
同一stemが複数ある場合はbuild errorになる。

### 記事metadata

```typst
#show: post.with(
  title: "記事タイトル",
  summary: "記事の要約（プレーンテキスト）",
  date: datetime(year: 2026, month: 4, day: 12),
  update: datetime(year: 2026, month: 4, day: 20), // 任意
  author: "gomazarashi",                           // 任意（省略時はsite author）
  tags: ("Typst", "Web"),                          // 任意
  aliases: ("/old-url/",),                         // 任意
)
```

- 公開記事では `title` / `summary` / `date` が必須。
- `date` / `update` はTypstの `datetime` 型で指定する（文字列は不可）。
- filenameは `yyyymmdd-slug.typ`。filenameの日付と `date` が一致しない場合はbuild error。
- `update` が `date` より前の場合はbuild error。
- 記事OG内の著者は `author` があればそれを、なければ`site.info.author`を使う。

### 長いタイトルと `og-title`

OG画像内のタイトルは実測しながら自動で縮小し、最大4行まで表示する。
それでも収まらない場合はproduction buildが失敗する。
productionを止めたくない場合のみ、短縮用の `og-title` を指定する。

```typst
og-title: "短縮したタイトル",
```

`og-title` はOG画像とsocial title（`og:title` / `twitter:title`）に使われる。
browserの `<title>` は元のタイトルのまま。

### custom OG image

記事metadataの `og-image` で画像を差し替えられる（将来用）。

```typst
og-image: "/images/custom/foo.png",
og-image-alt: "画像の説明",
```

指定したfileは `assets/` または `docs/` に存在する必要がある。

### draft

- production build（`just build`）は `tola build --skip-drafts` を使い、
  draftのHTMLもOG PNGも公開しない。
- `just serve` はローカル確認用にdraft込みでOGを生成する。
- title / tagsなどを変更した場合は `just og` を再実行する。
  OG画像のwatchは行わない。

### SNS cache

OG画像やmetadataを更新しても、SNS側のcacheが残ることがある。
その場合は各SNSのcache更新（再クロール）を待つか、投稿し直す。

## ディレクトリ運用

- `docs/` はビルド成果物の出力先。
- `.tola/` は Tola の内部作業ディレクトリ。
- `docs/` は Git 管理し、`just build` で更新してから commit / push する。
- GitHub Pages は `Deploy from a branch` を選び、公開元を `main` ブランチの `/docs` に設定する。
- `public/` は旧ビルド出力先として不要だが、誤生成された場合に備えて引き続き Git 管理しない。
- `.tola/` は Git 管理しない運用（`.gitignore` 設定済み）。
- `assets/images/og/` と `.og/` はOG生成用の中間ファイルであり、Git 管理しない。
- `docs/images/og/` は公開artifactなので Git 管理する。

## ブランチ運用

- `main` は公開中の安定版です。`main` ブランチの `docs/` を GitHub Pages から公開します。
- `develop` は次回公開分を統合・確認するブランチです。
- 機能・修正ごとに `develop` から作業ブランチを作成し、確認後に `develop` へマージします。
- 公開時に `develop` を `main` へマージします。`docs/` のビルド結果はソース変更とあわせてコミットします。

## 記事ファイル命名規則

`content/posts/` 配下の記事は、以下の形式で作成する。

`yyyymmdd-slug.typ`

例: `20260412-first-post.typ`
