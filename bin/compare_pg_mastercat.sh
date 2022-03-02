#!/bin/bash

PGHOST="localhost"
PGPORT="5433"
PGDATABASE="yugabyte"
PGUSER="yugabyte"
PGPASSWORD=""

MASTER_ADDRESSES="127.0.0.1:7100,127.0.0.2:7100,127.0.0.3:7100"

# Load database connection inf
set -o allexport
set +o allexport

# Read query into a variable
getdbs="select datname from pg_database where datname not in('template0','template1')"

# If psql is not available, then exit
if ! command -v ysqlsh > /dev/null; then
  echo "This script requires psql to be installed and on your PATH ..."
  exit 1
fi

# reset output files
cat /dev/null > pgall
cat /dev/null > yball
cat /dev/null > pgall.sorted
cat /dev/null > yball.sorted

# Get tables and indexes from postgres side
ysqlsh -t -A -c "${getdbs}" | while read -a dbs ; do

  #echo "Processing ${dbs}..."
  ysqlsh -t -A "${dbs}" -c "(select tablename from pg_tables where schemaname not in('information_schema','pg_catalog')) union (select indexname from pg_indexes where schemaname not in('information_schema','pg_catalog'))" | grep -v '_pkey' >> pgall

done

# Get tables (including indexes) from master catalog side
${YBENV_DIR}/candidates/current/bin/yb-admin --master_addresses $MASTER_ADDRESSES list_tables include_table_type | grep -v catalog | awk -F'.' '{print $2}' | awk -F' ' '{print $1}' > yball
#/home/yugabyte/bin/yb-admin --master_addresses $MASTER_ADDRESSES list_tables include_table_type | grep -v catalog | awk -F'.' '{print $2}' | awk -F' ' '{print $1}' > yball

# sort and diff

sort pgall > pgall.sorted
sort yball > yball.sorted

comm pgall.sorted yball.sorted -3
