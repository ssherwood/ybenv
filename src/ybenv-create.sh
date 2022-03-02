#!/usr/bin/env bash

function __ybenv_create() {
    ${YBENV_DIR}/candidates/current/bin/yb-ctl --data_dir ${YBENV_DIR}/data/yugabyte-data-${YBENV_CURRENT} create --rf=3 --ysql_num_shards_per_tserver=1 $1 $2 $3 $4 $5 $6 $7 $8 $9
    #--rf=1 --listen_ip=$LOCAL_IP
    #--rf=3 create --ysql_num_shards_per_tserver=1
}
