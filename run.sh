#!/bin/bash

IMAGE="$1"
PORT="$2"
HTTP_PORT="$3"
SHARED_SECRET="$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM"
ETH_RPC_URL=https://rpc.ankr.com/eth
PYTHONPATH=/home/baobg/week1/example-ctf-challenge/mp.py
PUBLIC_IP=127.0.0.1
FLAG="Hello"

echo "[+] running challenge"
exec docker run \
    -e "PORT=$PORT" \
    -e "HTTP_PORT=$HTTP_PORT" \
    -e "ETH_RPC_URL=$ETH_RPC_URL" \
    -e "FLAG=$FLAG" \
    -e "PUBLIC_IP=$PUBLIC_IP" \
    -e "SHARED_SECRET=$SHARED_SECRET" \
    -p "$PORT:$PORT" \
    -p "$HTTP_PORT:$HTTP_PORT" \
    "$IMAGE"
