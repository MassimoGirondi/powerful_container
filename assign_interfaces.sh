#!/bin/bash

source .env
SERVER_NAMESPACE=$(docker inspect --format='{{.State.Pid}}' $SERVER_CONTAINER)
CLIENT_NAMESPACE=$(docker inspect --format='{{.State.Pid}}' $CLIENT_CONTAINER)

mkdir -p /var/run/netns/
ln -sfT /proc/$SERVER_NAMESPACE/ns/net /var/run/netns/$SERVER_CONTAINER
ln -sfT /proc/$CLIENT_NAMESPACE/ns/net /var/run/netns/$CLIENT_CONTAINER

ip netns list

ip netns exec $SERVER_CONTAINER ip link list
ip netns exec $CLIENT_CONTAINER ip link list


ip link set dev $SERVER_IFACE netns $SERVER_CONTAINER
ip link set dev $CLIENT_IFACE netns $CLIENT_CONTAINER

ip netns exec $SERVER_CONTAINER ip link list
ip netns exec $CLIENT_CONTAINER ip link list

ip netns exec $SERVER_CONTAINER ip addr add $SERVER_IP/24 dev $SERVER_IFACE 
ip netns exec $SERVER_CONTAINER ip link set dev $SERVER_IFACE up

ip netns exec $CLIENT_CONTAINER ip addr add $CLIENT_IP/24 dev $CLIENT_IFACE 
ip netns exec $CLIENT_CONTAINER ip link set dev $CLIENT_IFACE up
