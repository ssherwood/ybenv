set -eux

# Please fill out the hosts that need to enable tracing. Space separated.
# Optionally, you may want to change the sleep time and/or the flags to be updated.
ALL="127.0.0.1 127.0.0.2 127.0.0.3"
HOSTS=$ALL

BIN_PATH="${YBENV_DIR}/candidates/current/bin"
#BIN_PATH="/home/yugabyte/tserver/bin"

# Useful for analysing traces
# !egrep "ProcessResponseFromTserver|initiated|tablet_rpc.cc:184|async_rpc.cc:343|inbound_call.cc" %
# | sort -n -k 2
# egrep "Created InboundCall|Destroying InboundCall|Done(OK)|Outbound Call
# initiated.|ProcessResponseFromTserver(OK)|Queueing success response|RpcDispatched
# Asynchronously|Tracing op:|Transfer finished|Rpc initiated to"

for IP in $HOSTS; do
HOST=${IP}:9100
#${BIN_PATH}/yb-ts-cli --server_address=${HOST} set_flag -force print_trace_every 1000
${BIN_PATH}/yb-ts-cli --server_address=${HOST} set_flag -force enable_tracing 1
${BIN_PATH}/yb-ts-cli --server_address=${HOST} set_flag -force collect_end_to_end_traces 0
#${BIN_PATH}/yb-ts-cli --server_address=${HOST} set_flag -force trace_docdb_calls 0 <- not working???
#${BIN_PATH}/yb-ts-cli --server_address=${HOST} set_flag -force rpc_slow_query_threshold_ms 1000
done

sleep 30s

for IP in $HOSTS; do
HOST=${IP}:9100
${BIN_PATH}/yb-ts-cli --server_address=${HOST} set_flag -force print_trace_every 0
${BIN_PATH}/yb-ts-cli --server_address=${HOST} set_flag -force enable_tracing 0
${BIN_PATH}/yb-ts-cli --server_address=${HOST} set_flag -force collect_end_to_end_traces 0
#${BIN_PATH}/yb-ts-cli --server_address=${HOST} set_flag -force trace_docdb_calls 0
#${BIN_PATH}/yb-ts-cli --server_address=${HOST} set_flag -force rpc_slow_query_threshold_ms 10000
done

#echo "You may find it useful to :"
#echo "egrep 'Created InboundCall|Destroying InboundCall|Done.OK.|Outbound Call initiated.|ProcessResponseFromTserver.OK.|Queueing success response|RpcDispatched Asynchronously|Tracing op:|Transfer finished|Rpc initiated to' log"
#echo  " optionally \n | sort -n -k 2 \n      to see the timeline".
exit
