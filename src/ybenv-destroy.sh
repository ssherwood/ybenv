#!/usr/bin/env bash

function __ybenv_destroy() {
    ${YBENV_DIR}/candidates/current/bin/yb-ctl --data_dir ${YBENV_DIR}/data/yugabyte-data-${YBENV_CURRENT} destroy $1 $2 $3 $4 $5 $6 $7 $8 $9
}
