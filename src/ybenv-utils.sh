#!/usr/bin/env bash

#
#
#

function __ybenv_echo() {
    if [[ "$ybenv_colour_enable" == 'false' ]]; then
        echo -e "$2"
    else
        echo -e "\033[1;$1$2\033[0m"
    fi 
}

function __ybenv_echo_red() {
    __ybenv_echo "31m" "$1"
}

function __ybenv_echo_yellow() {
    __ybenv_echo "33m" "$1"
}
