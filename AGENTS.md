# AGENTS.md

## リポジトリの概要

このリポジトリは、`https://gomazarashi.com/` で公開している個人Webサイトのソースコードと、GitHub Pagesで公開する生成済みファイルを管理するリポジトリです。

主な開発環境は次のとおりです。

* Typst 0.15.0
* Tola 0.7.1
* just 1.52.0
* GitHub Pages

依存ツールのバージョンやデプロイ方式は、明示的な依頼がない限り変更しないでください。

必要なコマンドが利用できるか確認するときは、次を使用します。

```bash
just doctor
```

## ブランチ運用

作業ブランチは `develop` から作成し、確認後に `develop` へマージしてください。
`main` へのマージ・push は、ユーザーが明示的に依頼した場合のみ行ってください。

## ソースと生成物

主に直接編集する対象は次のとおりです。

* `content/`
* `templates/`
* `utils/`
* `og/`
* `assets/`
* `tola.toml`
* `justfile`
* `scripts/`

`docs/` はTolaが生成するビルド成果物です。`docs/` 内のHTML、CSS、JavaScript、sitemapなどは原則として直接編集しないでください。

変更は対応するソース側に加え、その後ビルドして `docs/` を再生成します。

```text
content / templates / utils / assets
        ↓
      Tola
        ↓
      docs/
        ↓
 GitHub Pages
```

`docs/` は生成物ですが、GitHub Pagesの公開元でもあるためGit管理されています。

したがって、

* `docs/` を直接編集しない
* ソース変更後は `docs/` を再生成する
* 必要な `docs/` の差分もコミット対象に含める

という運用を守ってください。

## ビルド

サイトの出力に影響する変更を行った場合は、作業完了前に次を実行してください。

```bash
just build
```

`just build` は現在、次の処理を行います。

```bash
just check
python3 scripts/build-og.py
rm -rf docs/images/og
tola build --skip-drafts
touch docs/.nojekyll
./scripts/remove-404-from-sitemap.sh
./scripts/add-tools-to-sitemap.sh
python3 scripts/validate-og.py
# docs/.nojekyll と docs/CNAME の存在確認、CNAME の内容確認
```

公開用の確認では、原則として `tola build` を直接実行するのではなく `just build` を使用してください。

ビルド後は、意図した変更が `docs/` に反映されていることを確認してください。

OG画像だけを再生成する場合（記事の title / summary / date / tags 変更後など）は
`just og` を使用します。`docs/` への反映には `just build` が必要です。

OGテンプレートを変更した場合は `just test-og` でfixtureテストを実行してください
（一時データのみ使用し、公開contentには触れません）。

## OG画像（OGP）

OG画像とOGP metadataは次のpipelineで生成します。

```text
content/posts/*.typ の metadata
        ↓ Tola 標準の <tola-meta>
tola query（.og/posts.json）
        ↓ scripts/build-og.py
og/*.typ（Typst） → assets/images/og/（Git管理しない）
        ↓ Tola の nested assets
docs/images/og/（Git管理する公開artifact）
```

注意事項:

* `docs/images/og/*.png` を直接手編集しない。必ず `og/*.typ` または記事metadataを変更し、`just build` で再生成する。
* 記事metadataの single source of truth は `content/posts/*.typ`。OG用に別ファイルへ手入力しない。
* 記事metadataの抽出に独自parserを使わない。`tola query` を使う。
* OG生成にはPython 3.11+（標準ライブラリのみ）と日本語フォント（`Noto Sans JP` または `Noto Sans CJK JP`）が必要。どちらもない場合buildは失敗する。フォールバックさせない。
* `assets/images/og/` と `.og/` はGit管理しない。`docs/images/og/` はGit管理する。
* OG画像は1200x630のPNG。`--ppi 144` を明示して生成する。
* productionではdraftのHTMLもOG PNGも公開しない（`tola build --skip-drafts`）。
* `utils/meta.typ` がOGP metadataの責務を持つ。site URL/titleは `tola.toml` と `@tola/site` から取得し、ハードコードしない。

## デプロイ

GitHub Pagesの公開元は `main` ブランチの `/docs` です。

現在、このリポジトリには独自の `.github/workflows/` はありません。GitHub Pages側が自動的に `pages build and deployment` workflowを実行します。

このworkflowは `docs/` をGitHub Pagesへ公開するための処理を行いますが、Typst、Tola、`just build` は実行しません。

そのため、ソースだけを変更してpushしても、GitHub上で `docs/` が自動生成されることはありません。サイト出力に影響する変更では、push前に `just build` を実行してください。

明示的な依頼がない限り、次のようなデプロイ方式の変更を行わないでください。

* `.github/workflows/` を追加してビルドをActionsへ移す
* GitHub Pagesの公開元を変更する
* `docs/` をGit管理しない方式へ変更する
* `gh-pages` ブランチを導入する

## `docs/.tola/` と `docs/.nojekyll`

このサイトはTolaが完成した静的HTMLを生成しており、Jekyllによる追加処理を使用しません。

公開方式はGitHub Pagesのbranch publishing（`main` ブランチの `/docs`）のまま維持します。branch publishingでは、`docs/.nojekyll` がないとGitHub PagesがJekyll処理を行い、`.`で始まるディレクトリが公開artifactから除外されます。

Tolaが生成するHTMLは、次のような公開アセットを参照します。

```text
/.tola/enhance-6b400663.css
```

対応するファイルは `docs/.tola/` に生成されます。`docs/.tola/` はTola生成HTMLが参照する公開アセットであり、`.nojekyll` によって本番でも配信されます。

そのため、次の運用を守ってください。

* `docs/.nojekyll` はGitHub PagesによるJekyll処理を無効化するために必要。
* `docs/.nojekyll` は `just build`（および `just rebuild`）が `tola build --skip-drafts` の後に生成し、build時に存在を検証する。手動で維持・編集しない。
* `docs/.nojekyll` を削除しない。
* `docs/.tola/` にファイルが存在することを理由に本番での配信可否を判断しない（`.nojekyll` により配信される）。
* GitHub Actions deploymentへの移行は行わない。

## `docs/CNAME` を保護する

カスタムドメインは `gomazarashi.com` です。

`docs/CNAME` の内容は次のとおりです。

```text
gomazarashi.com
```

Tola 0.7.1 は `tola.toml` の `[site.info].url` から `docs/CNAME` を毎回の `tola build` で自動生成します（`[build.assets].flatten` に CNAME の source がないため）。`just build` はビルド後に存在と内容を検証します。

`just clean` は `rm -rf docs .tola` を、`just rebuild` はその後に build を実行しますが、`tola build` が CNAME を再生成するため `just rebuild` は動作します（確認済み）。ただし CNAME は公開ドメインに直結するため、clean / rebuild 後は内容が `gomazarashi.com` であることを確認してください。

`docs/CNAME` は build のたびに上書きされるため、直接編集しないでください。
