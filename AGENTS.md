# AGENTS.md

## リポジトリの概要

このリポジトリは、`https://gomazarashi.com/` で公開している個人Webサイトのソースコードと、GitHub Pagesで公開する生成済みファイルを管理するリポジトリです。

主な開発環境は次のとおりです。

* Typst 0.14.2
* Tola 0.7.1
* just 1.52.0
* GitHub Pages

依存ツールのバージョンやデプロイ方式は、明示的な依頼がない限り変更しないでください。

必要なコマンドが利用できるか確認するときは、次を使用します。

```bash
just doctor
```

## ソースと生成物

主に直接編集する対象は次のとおりです。

* `content/`
* `templates/`
* `utils/`
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
tola build
./scripts/remove-404-from-sitemap.sh
```

公開用の確認では、原則として `tola build` を直接実行するのではなく `just build` を使用してください。

ビルド後は、意図した変更が `docs/` に反映されていることを確認してください。

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

## `docs/.tola/` に関する注意

Tolaが生成するHTMLは、現在次のようなファイルを参照します。

```text
/.tola/enhance-6b400663.css
```

対応するファイルは `docs/.tola/` に生成されます。

一方、現在のGitHub Pagesは `docs/` をJekyllで処理しており、実際のPages公開artifactには `.tola/` が含まれていません。

そのため、`docs/.tola/` にファイルが存在することだけを理由に、本番環境でも利用可能だと判断しないでください。

`.nojekyll` の追加やカスタムGitHub Actionsへの移行はデプロイ方式に関わるため、明示的な依頼がない限り実施しないでください。

## `docs/CNAME` を保護する

カスタムドメインは `gomazarashi.com` です。

`docs/CNAME` は削除・変更しないでください。現在の内容は次のとおりです。

```text
gomazarashi.com
```

`just clean` は次を実行します。

```bash
rm -rf docs .tola
```

また、`just rebuild` は `clean` の後に `build` を実行します。

現在、`CNAME` を `docs/` へ自動生成またはコピーする設定はないため、`just clean` または `just rebuild` を実行すると `docs/CNAME` が失われる可能性があります。

通常の作業では必要がない限り `just clean` や `just rebuild` を使用せず、`just build` を使用してください。

`just clean` または `just rebuild` を実行した場合は、作業完了前に `docs/CNAME` が存在し、内容が `gomazarashi.com` であることを必ず確認してください。
