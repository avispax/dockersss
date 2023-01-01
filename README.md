# dockersss

docker で単発モノはとりあえずここからスタートして、大きくなってきたら別リポジトリとか、そういう使い方用のリポジトリ。
docker は docker-compose.yml を使いながらやろうかな。

そういう性質でやるので、Dockerfile とそのデータは各ディレクトリ内だけで完結してくれると助かるっす。
プロセス単位でなんか連携するとかなら Data 部を外に出してもいいけど。

## 1 : とりあえず python3 を適当に定義。

## 2 : Rust もこっちに移植。

Docker-compose はまだ作ってないけど。

## 3 : mySQL を触りたいので追加。

### 3-1 : 起動～中に入る

1. docker compose build mySQL
2. docker compose up -d mySQL
3. docker compose ps
4. docker compose exec mySQL bash

### 3-2 : mySQL を動かす

1. mysql -u docker -p
2. docker ← パスワード入力
3. show databases;
4. show tables;
5. use test_db;

3.はあると思うけど、4 は 0 件のハズ。

### 3-3 : A5m2 で遊ぶ

1. 3-2 に接続する。とりあえずまずは root/root で。
2. mysql_db とかいうあたりの テーブル users で docker ユーザーの権限を全部 root とお揃いにする。
3. docker/docker で入り直す。
4. 好きに遊ぶ。

## 4 : VueCli + TypeScript 環境で、TypeScript を中心に遊ぶ。

しかしうちの PC はモニターが綺麗だ。マジで。うっとりする。

### 4-1 : とりあえず docker-compose.yml を定義する。

まずはここから。  
ド定番に docker-compose.yml と Dockerfile を定義する。

### 4-2 : docker 操作

- docker-compose build vuecli
- docker-compose up -d vuecli
- docker-compose ps
- docker-compose exec vuecli ash

alpine は bash ではなく ash 採用なので。

### 4-3 : alpine 内に vue 環境作成

- vue create my-test
- cd my-test
- npm install
- npm run server

## 5 : TypeScript

TypeScript のために、まずは node とかから始めているぞい。

### 5-1 : node を用意する。TypeScript は node.js で動く。

1. docker-compose.yml を node 用に書く。
2. docker-compose up -d ts
3. docker-compose ps
4. docker-compose exec ts bash

### 5-2 : TypeScript をインストール

1. npm install --save-dev ts-node typescript
2. npm install -D typescript @types/node@latest
3. npx tsc --init
4. npm install -D ts-node

### 5-3 : 実行

1. npx ts-node file1.ts
