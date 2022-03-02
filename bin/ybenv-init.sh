#!/usr/bin/env bash

# 
#
#

if [ -z "$YBENV_VERSION" ]; then
    export YBENV_VERSION="0.0.1"
fi

if [ -z "$YBENV_DIR" ]; then
    export YBENV_DIR="$HOME/.ybenv"
fi

#TODO need a better way
if [ -z "$YBENV_CURRENT" ]; then
    export YBENV_CURRENT="2.8.1.0"
    #export YBENV_CURRENT="2.11.3.0"
fi

scripts=($(find "${YBENV_DIR}/src" "${YBENV_DIR}/ext" -type f -name 'ybenv-*.sh'))
for f in "${scripts[@]}"; do
    source "$f"
done

### helper aliases

alias yb-admin='${YBENV_DIR}/candidates/current/bin/yb-admin -master_addresses $(curl $(hostname -i):12000/varz 2> /dev/null | grep tserver_master_addrs | awk -F= "{print \$2}")'
