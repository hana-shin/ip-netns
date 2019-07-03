#!/usr/bin/bash

ip netns add host1
ip netns add host2

ip link add p-h1 type veth peer name p2-br
ip link add p-h2 type veth peer name p3-br

ip link set p-h1 netns host1
ip link set p-h2 netns host2

brctl addbr bridge
brctl addif bridge p2-br
brctl addif bridge p3-br

ip netns exec host1 ip addr add 10.0.0.10/8 dev p-h1
ip netns exec host2 ip addr add 10.0.0.20/8 dev p-h2

ip netns exec host1 ip link set p-h1 up
ip netns exec host2 ip link set p-h2 up

ip netns exec host1 ip link set lo up
ip netns exec host2 ip link set lo up

ip link set p2-br up
ip link set p3-br up
ip link set bridge up
