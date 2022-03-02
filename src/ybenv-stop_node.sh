#!/usr/bin/env bash

function __ybenv_stop_node() {
    ${YBENV_DIR}/candidates/current/bin/yb-ctl --data_dir ${YBENV_DIR}/data/yugabyte-data-${YBENV_CURRENT} stop_node $1
}
