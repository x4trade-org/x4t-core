#!/bin/bash
X4TRADED="/usr/local/bin/witness_node"

# For blockchain download
VERSION=`cat /etc/x4trade/version`

## Supported Environmental Variables
#
<<<<<<< HEAD
#   * $X4TRADED_SEED_NODES
#   * $X4TRADED_RPC_ENDPOINT
#   * $X4TRADED_PLUGINS
#   * $X4TRADED_REPLAY
#   * $X4TRADED_RESYNC
#   * $X4TRADED_P2P_ENDPOINT
#   * $X4TRADED_WITNESS_ID
#   * $X4TRADED_PRIVATE_KEY
#   * $X4TRADED_TRACK_ACCOUNTS
#   * $X4TRADED_PARTIAL_OPERATIONS
#   * $X4TRADED_MAX_OPS_PER_ACCOUNT
#   * $X4TRADED_ES_NODE_URL
#   * $X4TRADED_TRUSTED_NODE
=======
#   * $BITSHARESD_SEED_NODES
#   * $BITSHARESD_RPC_ENDPOINT
#   * $BITSHARESD_PLUGINS
#   * $BITSHARESD_REPLAY
#   * $BITSHARESD_RESYNC
#   * $BITSHARESD_P2P_ENDPOINT
#   * $BITSHARESD_WITNESS_ID
#   * $BITSHARESD_PRIVATE_KEY
#   * $BITSHARESD_TRACK_ACCOUNTS
#   * $BITSHARESD_PARTIAL_OPERATIONS
#   * $BITSHARESD_MAX_OPS_PER_ACCOUNT
#   * $BITSHARESD_ES_NODE_URL
#   * $BITSHARESD_ES_START_AFTER_BLOCK
#   * $BITSHARESD_TRUSTED_NODE
>>>>>>> e3e2ceed594585572f7566195e831c84456f5f94
#

ARGS=""
# Translate environmental variables
if [[ ! -z "$X4TRADED_SEED_NODES" ]]; then
    for NODE in $X4TRADED_SEED_NODES ; do
        ARGS+=" --seed-node=$NODE"
    done
fi
if [[ ! -z "$X4TRADED_RPC_ENDPOINT" ]]; then
    ARGS+=" --rpc-endpoint=${X4TRADED_RPC_ENDPOINT}"
fi

if [[ ! -z "$X4TRADED_REPLAY" ]]; then
    ARGS+=" --replay-blockchain"
fi

if [[ ! -z "$X4TRADED_RESYNC" ]]; then
    ARGS+=" --resync-blockchain"
fi

if [[ ! -z "$X4TRADED_P2P_ENDPOINT" ]]; then
    ARGS+=" --p2p-endpoint=${X4TRADED_P2P_ENDPOINT}"
fi

if [[ ! -z "$X4TRADED_WITNESS_ID" ]]; then
    ARGS+=" --witness-id=$X4TRADED_WITNESS_ID"
fi

if [[ ! -z "$X4TRADED_PRIVATE_KEY" ]]; then
    ARGS+=" --private-key=$X4TRADED_PRIVATE_KEY"
fi

if [[ ! -z "$X4TRADED_TRACK_ACCOUNTS" ]]; then
    for ACCOUNT in $X4TRADED_TRACK_ACCOUNTS ; do
        ARGS+=" --track-account=$ACCOUNT"
    done
fi

if [[ ! -z "$X4TRADED_PARTIAL_OPERATIONS" ]]; then
    ARGS+=" --partial-operations=${X4TRADED_PARTIAL_OPERATIONS}"
fi

if [[ ! -z "$X4TRADED_MAX_OPS_PER_ACCOUNT" ]]; then
    ARGS+=" --max-ops-per-account=${X4TRADED_MAX_OPS_PER_ACCOUNT}"
fi

if [[ ! -z "$X4TRADED_ES_NODE_URL" ]]; then
    ARGS+=" --elasticsearch-node-url=${X4TRADED_ES_NODE_URL}"
fi

<<<<<<< HEAD
if [[ ! -z "$X4TRADED_TRUSTED_NODE" ]]; then
    ARGS+=" --trusted-node=${X4TRADED_TRUSTED_NODE}"
=======
if [[ ! -z "$BITSHARESD_ES_START_AFTER_BLOCK" ]]; then
    ARGS+=" --elasticsearch-start-es-after-block=${BITSHARESD_ES_START_AFTER_BLOCK}"
fi

if [[ ! -z "$BITSHARESD_TRUSTED_NODE" ]]; then
    ARGS+=" --trusted-node=${BITSHARESD_TRUSTED_NODE}"
>>>>>>> e3e2ceed594585572f7566195e831c84456f5f94
fi

## Link the x4trade config file into home
## This link has been created in Dockerfile, already
ln -f -s /etc/x4trade/config.ini /var/lib/x4trade

# Plugins need to be provided in a space-separated list, which
# makes it necessary to write it like this
if [[ ! -z "$X4TRADED_PLUGINS" ]]; then
   exec $X4TRADED --data-dir ${HOME} ${ARGS} ${X4TRADED_ARGS} --plugins "${X4TRADED_PLUGINS}"
else
   exec $X4TRADED --data-dir ${HOME} ${ARGS} ${X4TRADED_ARGS}
fi
