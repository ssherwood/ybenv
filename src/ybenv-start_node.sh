#!/usr/bin/env bash

function __ybenv_start_node() {
    ${YBENV_DIR}/candidates/current/bin/yb-ctl --data_dir ${YBENV_DIR}/data/yugabyte-data-${YBENV_CURRENT} start_node $1 $2 $3 $4 $5 $6 $7 $8 $9
}
