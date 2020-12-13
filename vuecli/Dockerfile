FROM node:lts-alpine

# カレントワーキングディレクトリとして '/usr/src/app' フォルダを指定する。
WORKDIR /usr/src/app

# プロジェクトの依存ライブラリをインストールする
RUN apk update && \
    npm install -g npm && \
    npm install -g @vue/cli
