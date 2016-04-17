# Open Disaster Information Project

[![Build Status](https://travis-ci.org/c4w/disaster-information.svg?branch=master)](https://travis-ci.org/c4w/disaster-information)

このプロジェクトは災害情報を配信するための実験的なプロジェクトです。

このプロジェクトは以下のことを目的としています。

* 絶対に落ちない強固なインフラであること。万が一落ちても即座に復旧できるポータビリティが高い仕組みであること。
* 災害情報はAPIとして配信できること。複数のフロントエンドで再利用が可能であること。
* 導入に際してなるべく学習コストが低いこと。
* オープンであり汎用性が高いテクノロジーを使用していること。
* 自動化がしやすいこと。

## APIのエンドポイント

http://c4w.github.io/disaster-information/api/v1/pages.json

## 運用方法

1. このリポジトリの`master`ブランチの[_site](https://github.com/c4w/disaster-information/tree/gh-pages)ディレクトリ内にJekyllの記事と同じフォーマット（マークダウン）でテクストファイルをpushしてください。
2. `master`ブランチに変更が加わるとTravis CIによって自動的にAPIとして利用可能なJSONファイルが生成されます。（ただし生成されるまでに数分かかります。）

##

## 既知の問題

* Travis CIによってJSONが生成されるまでに数分かかりますが、Travis CIの有料アカウントを使用するか、例えばAWS Lambda等の別のインフラを使用することで解決できると思います。
* マークダウンの学習コストが高い？
* そもそもGitの学習コストが高い？（和歌山県など自治体での導入事例は既にあるので問題ないと思われる。）
* GitHubに依存するのはどうよ？（とりあえず独自ドメインを割り当てて運用し、将来独自のインフラに移行することも可能）

その他、いろいろあるかもですが、ご意見やご感想は[Issue](https://github.com/c4w/disaster-information/issues)でどうぞ。
