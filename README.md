
# export YBENV_CURRENT

export YBENV_CURRENT=2.8.1.0

# change current dirs

ln -sfn candidates/yugabyte-${YBENV_CURRENT} current
ln -sfn data/yugabyte-data-${YBENV_CURRENT} current



# yb-amin Helper

In addition to mapping yb-ctl commands, ybenv also wraps yb-admin, just run ybenv admin <any adming command/args>
