#!/usr/bin/env bash

function __ybenv_admin() {
    ${YBENV_DIR}/candidates/current/bin/yb-admin -master_addresses $(curl $(hostname -i):12000/varz 2> /dev/null | grep tserver_master_addrs | awk -F= "{print \$2}") $1 $2 $3 $4 $5 $6 $7 $8 $9
}
