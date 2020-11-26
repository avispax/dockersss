# dockersss

dockerで単発モノはとりあえずここからスタートして、大きくなってきたら別リポジトリとか、そういう使い方用のリポジトリ。
dockerはdocker-compose.ymlを使いながらやろうかな。

そういう性質でやるので、Dockerfileとそのデータは各ディレクトリ内だけで完結してくれると助かるっす。
プロセス単位でなんか連携するとかならData部を外に出してもいいけど。

## 1 : とりあえずpython3を適当に定義。

## 2 : Rustもこっちに移植。

Docker-composeはまだ作ってないけど。

## 3 : mySQL を触りたいので追加。

### 3-1 : 起動～中に入る

1. docker-compose build mySQL
2. docker-compose up -d mySQL
3. docker-compose ps
4. docker-compose exec mySQL bash

### 3-2 : mySQLを動かす

1. mysql -u docker -p
2. docker   ←パスワード入力
3. show databases;
4. show tables;

3.はあると思うけど、4は0件のハズ。

### 3-3 : A5m2 で遊ぶ

1. 3-2 に接続する。とりあえずまずはroot/rootで。
2. mysql_dbとかいうあたりの テーブル users で docker ユーザーの権限を全部rootとお揃いにする。
3. docker/dockerで入り直す。
4. 好きに遊ぶ。
