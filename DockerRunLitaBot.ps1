# PowerShellの場合のdocker runスクリプト例。
# 環境変数は、botのソースにあわせて追加してください。
Param
(
    [string]$tag="latest",
    [string]$repo,
    [string]$branch
)

docker run `
  --link lita_redis:redis `
  --name lita_bot `
  -e BOT_SOURCE_REPOSITORY=$repo `
  -e BOT_SOURCE_BRANCH=$branch `
  "myamyu/lita:$tag"
