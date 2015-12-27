#!/bin/bash

function log()
{
    local _now=$(date '+%Y-%m-%d_%H:%M:%S')
    local _level="${1}"
    local _msg="${2}"
    echo "$_now | $_level | $_msg"
}

declare -r BOT_SOURCE_DIR=/opt/lita/src
if [ -z $BOT_SOURCE_BRANCH ]; then
    BOT_SOURCE_BRANCH=master
fi

log 'INFO' 'Start Run Bot!'
if [ ! -d $BOT_SOURCE_DIR ]; then
    if [ -z $BOT_SOURCE_REPOSITORY ]; then
        lita new $BOT_SOURCE_DIR
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

log 'INFO' 'Run Bot!'
lita
