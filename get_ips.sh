#!/bin/bash
SERVER_CONTAINER="csd_server"
CLIENT_CONTAINER="csd_client"
# This is not ideal...
NET_NAME="powerful_workspace_default"

docker inspect --format="{{.NetworkSettings.Networks.${NET_NAME}.IPAddress}}" ${SERVER_CONTAINER}
docker inspect --format="{{.NetworkSettings.Networks.${NET_NAME}.IPAddress}}" ${CLIENT_CONTAINER}
