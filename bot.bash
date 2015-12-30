#!/bin/bash

function log()
{
    local _now=$(date '+%Y-%m-%d_%H:%M:%S')
    local _msg="${1}"
    echo "$_now|$_msg"
}

declare -r BOT_SOURCE_DIR=/opt/lita/src
if [ -z $BOT_SOURCE_BRANCH ]; then
    BOT_SOURCE_BRANCH=master
fi

log 'Start Run Bot!'
if [ ! -d $BOT_SOURCE_DIR ]; then
    if [ -z $BOT_SOURCE_REPOSITORY ]; then
        mkdir $BOT_SOURCE_DIR
        cat << EOF > $BOT_SOURCE_DIR/lita_config.rb
Lita.configure do |config|
  config.robot.name = "Lita"
  config.robot.log_level = :info
  config.robot.adapter = :shell
	config.redis.host = "redis"
	config.redis.port = ${REDIS_PORT_6379_TCP_PORT}
end
EOF
        cat <<EOF > $BOT_SOURCE_DIR/Gemfile
source "https://rubygems.org"
gem "lita"
EOF
    else
        git clone $BOT_SOURCE_REPOSITORY $BOT_SOURCE_DIR
    fi
fi

pushd $BOT_SOURCE_DIR
if [ ! -z $BOT_SOURCE_REPOSITORY ]; then
    git fetch
    git checkout $BOT_SOURCE_BRANCH
    git pull
fi

bundle install

log 'Run Bot!'
/opt/lita/bundle/bin/lita
