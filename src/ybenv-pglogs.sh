#!/usr/bin/env bash

# NOTE: requires lnav

function __ybenv_pglogs() {
    lnav `cat ${YBENV_DIR}/data/current/node-1/disk-1/pg_data/current_logfiles ${YBENV_DIR}/data/current/node-2/disk-1/pg_data/current_logfiles ${YBENV_DIR}/data/current/node-3/disk-1/pg_data/current_logfiles | awk '{ print substr( $0, 8 ) }'`
}
