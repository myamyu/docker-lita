Param([string]$vm)
docker-machine env --shell powershell $vm|Invoke-Expression
