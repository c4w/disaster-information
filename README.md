# GitHubページを使った災害情報配信用のJSON API

[![Build Status](https://travis-ci.org/c4w/disaster-information.svg?branch=master)](https://travis-ci.org/c4w/disaster-information)

このプロジェクトは災害情報を配信するための実験的なプロジェクトです。

このプロジェクトは以下のことを目的としています。

* 絶対に落ちない強固なインフラであること。万が一落ちても即座に復旧できるポータビリティが高い仕組みであること。
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

## APIのエンドポイント

http://c4w.github.io/disaster-information/api/v1/pages.json

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

## 運用方法

1. このリポジトリの`master`ブランチの[_posts](https://github.com/c4w/disaster-information/tree/master/_posts)ディレクトリ内にJekyllの記事と同じフォーマット（マークダウン）でテクストファイルをpushしてください。
2. `master`ブランチに変更が加わるとTravis CIによって自動的にAPIとして利用可能なJSONファイルが生成されます。（ただし生成されるまでに数分かかります。）

## 仕組み

* GitHubにマークダウンファイルを投稿すると、[Travis CI](https://travis-ci.org/)が発火して自動的にJSON APIが[gh-pages](https://github.com/c4w/disaster-information/tree/gh-pages)ブランチに生成されます。
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

## 既知の問題

* Travis CIによってJSONが生成されるまでに数分かかりますが、Travis CIの有料アカウントを使用するか、例えばAWS Lambda等の別のインフラを使用することで解決できると思います。
* マークダウンの学習コストが高い？
* そもそもGitの学習コストが高い？（和歌山県など自治体での導入事例は既にあるので問題ないと思われる。）
* GitHubに依存するのはどうよ？（とりあえず独自ドメインを割り当てて運用し、将来独自のインフラに移行することも可能）

その他、いろいろあるかもですが、ご意見やご感想は[Issue](https://github.com/c4w/disaster-information/issues)でどうぞ。
