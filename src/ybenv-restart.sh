#!/usr/bin/env bash

function __ybenv_restart() {
    ${YBENV_DIR}/candidates/current/bin/yb-ctl --data_dir ${YBENV_DIR}/data/yugabyte-data-${YBENV_CURRENT} restart --tserver_flags "ysql_log_statement=all" $1 $2 $3 $4 $5 $6 $7 $8 $9
    #--tserver_flags "ysql_log_statement=all"
}
