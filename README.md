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
docker build -t myamyu/lita:latest .
```

### redisを起動

```
docker run --name lita_redis -p 6379:6379 -d redis
```

### 起動

```
docker run --name lita_bot --link lita_redis:redis "myamyu/lita:latest"
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

Hyper-Vでの実行
---------------

基本的には http://qiita.com/masatoshiitoh/items/30d9711f7a64e863032f のとおり。

### インストール

- Hyper-Vを有効化
- 外部向けの仮想スイッチを作成(仮に`vnetext01`という名前にしておく)
- docker toolboxをダウンロード https://www.docker.com/docker-toolbox
- ダウンロードしたインストーラーを実行

Virtualbox等、不要なものはチェックをはずすこと。

### コンテナのガワ作成

- 管理者権限でPower Shellを実行
- `docker-machine create --driver hyperv --hyperv-virtual-switch vnetext01 default`
 - vnetext01は予め外部向けの仮想Hyper-V上で作っておいたやつ
 - defaultは作成するVMの名前

起動に時間がかかったからかエラーになるけれど、できているのでHyper-V上で起動。

### dockerコマンドを使えるようにする

`docker-machine env --shell powershell default | Invoke-Expression`
このコマンドは毎回打つことになるので、スクリプトファイルを作っておきました。
```
DockerMachineEnv.ps1 -vm default
```
で実行してください。

TLSがどーのこーのってエラーになったら
`docker-machine regenerate-certs default`
で解決するはずです。

`docker run hello-world`
が、うまくいけばOKです。
(邪魔なので、あとで消しましょうね。)
