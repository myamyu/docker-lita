# PowerShellの場合のdocker runスクリプト例。
# 環境変数は、botのソースにあわせて追加してください。
Param
(
    [string]$tag="latest",
    [string]$repo,
    [string]$branch,
    [string]$cmd,
    [string]$name="lita_bot"
)

docker run `
  -i -t `
  --link lita_redis:redis `
  --name $name `
  -e BOT_SOURCE_REPOSITORY=$repo `
  -e BOT_SOURCE_BRANCH=$branch `
  "myamyu/lita:$tag" $cmd
