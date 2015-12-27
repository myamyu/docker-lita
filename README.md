lita bot docker
================

litaを動かすdockerコンテナです。  
litaのソースはgitリポジトリから取得するので、動かしたいlitaをgitに置いておいてください。

runのたびにgitから最新を取得するので、完全にreleaseするコンテナを作る場合は、
bot.bashの中身ごと全部Dockerfile内で全部動かしちゃってください。

使いかた
-------

### Dockerfileをbuild

```
cd /path/to/lita/docker/dir
docker build -t lita:0.0.1 .
```

### redisを起動

```
docker run --name lita_redis -p 6379:6379 -d redis
```


環境変数
--------

### gitリポジトリ関連

- `BOT_SOURCE_REPOSITORY`
  botのgitリポジトリを指定してください。  
  git cloneで取りにいくので、取れるようなURIを指定してください。  
  指定しなかった場合は、lita newで空のlitaを作ります。

- `BOT_SOURCE_BRANCH`
  botのブランチです。デフォルトはmasterになります。

### litaの設定関連

特に用意はしていません。  
botのソースにあわせて、環境変数を渡してあげてください。

