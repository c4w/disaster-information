# GitHubページを使った災害情報配信用のJSON API

[![Build Status](https://travis-ci.org/c4w/disaster-information.svg?branch=master)](https://travis-ci.org/c4w/disaster-information)

このプロジェクトは災害情報を配信するための実験的なプロジェクトです。

このプロジェクトは以下のことを目的としています。

* 強固なインフラであること。
* 災害情報はAPIとして配信できること。複数のフロントエンドで再利用が可能であること。
* 導入に際してなるべく学習コストが低いこと。
* 災害時に即座に導入することが可能であること。
* オープンであり汎用性が高いテクノロジーを使用していること。
* 自動化がしやすいこと。

もちろんこの方法がベストだとは思っていませんが、災害時に自治体等のサイトがダウンしてしまうという最悪の状態を防ぐための手段の一つとしてどうかなと考えてみました。

## この方法のメリット

* メインのサイトにCDNを適用してキャッシュされても、災害情報がAPI経由であればキャッシュの問題が解消される。
* 複数のフロントエンドをあらかじめ用意すればトラフィックの集中を防げる。
* 他言語対応が容易。
* GitHubの巨大なバックボーンを使用可能。AWSのS3等にバックボーンを変更することもわずかなコードの修正で可能。
* スタティックなファイルの配信なので安全。
* いちど構築してしまえば学習コストが低い。（と思う。笑）
* インフラのメンテナンスが不要。
* オペレーションミスがあってもGitで戻せて履歴も残せる。
* 無料。（ただし独自ドメインを割り当てた方がポータビリティが高くGitHubへの依存度も低い。。。と思う。）

## APIのエンドポイント

* 言語一覧
  * http://api.c4w.jp/api/v1/locale.json
* 言語別
  * 上記言語一覧に掲載されている各言語ごとのエンドポイント
  * 例：
    * 日本語(ja)： http://api.c4w.jp/api/v1/ja.json
    * 英語(en)： http://api.c4w.jp/api/v1/en.json

## APIの出力例

```
{
  "entries": [
    {
      "title": "Welcome to Jekyll!",
      "date": "2016-04-17 07:56:11 +0000",
      "url": "/2016/04/17/welcome-to-jekyll.html",
      "tags": [
        "避難情報,",
        "避難所情報"
      ],
      "lang": "ja",
      "body": "You’ll find this post in your _posts directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run jekyll serve, which launches a web server and auto-regenerates your site when a file is updated. To add new posts, simply add a file in the _posts directory that follows the convention YYYY-MM-DD-name-of-post.ext and includes the necessary front matter. Take a look at the source for this post to get an idea about how it works."
    }
  ]
}
```

## 導入方法

1. このリポジトリをフォークしてください。
2. [Travis CI](https://travis-ci.org/)にサインアップ。
3. Travis CIでリポジトリを有効化。
4. アクセストークンを[取得](https://github.com/settings/tokens)。
5. アクセストークンを[暗号化](https://docs.travis-ci.com/user/encryption-keys/)。
6. `.travis.yml`を書き換え。
7. GitHubにプッシュ。

## 記事の投稿方法

1. `master`ブランチの[_posts](https://github.com/c4w/disaster-information/tree/master/_posts)ディレクトリ内に[Jekyllの記事と同じフォーマット（.md）のファイル](https://github.com/c4w/disaster-information/blob/master/_posts/2016-04-18-example1.md)をpushしてください。またはGitHubの [New file] ボタンをクリックして`_posts`内に記事を作成してください。
2. `master`ブランチに変更が加わるとTravis CIによって自動的にAPIとして利用可能なJSONファイルが生成されます。（ただし生成されるまでに数分かかります。）

## 仕組み

* GitHubにマークダウンファイルを投稿すると、[Travis CIが発火](https://travis-ci.org/c4w/disaster-information)して自動的にJSON APIが[gh-pages](https://github.com/c4w/disaster-information/tree/gh-pages)ブランチに生成されます。
* JSONを生成するには、[Jekyll](https://jekyllrb.com/)と、アメリカ政府内の機関[18F](https://18f.gsa.gov/)が開発した[jekyll_pages_api](https://github.com/18F/jekyll_pages_api)というJekyllプラグインを使用しています。

## マークダウンフォーマットの例

```
---
title:  "Welcome to Jekyll!"
date:   2016-04-17 16:56:11 +0900
tags: 避難情報, 避難所情報
lang: ja
---
You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

To add new posts, simply add a file in the `_posts` directory that follows the convention `YYYY-MM-DD-name-of-post.ext` and includes the necessary front matter. Take a look at the source for this post to get an idea about how it works.
```

## 問題点

* Travis CIによってJSONが生成されるまでに数分かかる。
  * デスクトップで生成してgh-pagesにpushすることも可能
* マークダウンの学習コストが高いかも。
* そもそもGitの学習コストが高いかも。
  * 和歌山県や国土地理院などGitHubアカウントを持っている政府機関や自治体はすでにある。
  * GitHub上であればブラウザ上の操作だけで情報の追加が可能
* GitHubに依存することにネガティブな意見があるかもしれない。
  * オープンな技術を使っているので、他にも代替可能なサービスや手段はあり、必要以上に依存してるわけではない。

その他、いろいろあるかもですが、ご意見やご感想は[Issue](https://github.com/c4w/disaster-information/issues)でどうぞ。

## 開発

```
$ git clone git@github.com:c4w/disaster-information.git
$ cd disaster-information
$ bundle install --path vendor/bundle
```

Then:

```
$ bundle exec jekyll serve
```

Or

```
$ bundle exec jekyll build
```
