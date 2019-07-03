#!/usr/bin/bash

## add
ip netns add cl
ip netns add sv

ip link add p-h1 type veth peer name p2-br
ip link add p-h2 type veth peer name p3-br

ip link set p-h1 netns cl
ip link set p-h2 netns sv

brctl addbr bridge
brctl addif bridge p2-br
brctl addif bridge p3-br

ip netns exec cl ip addr add 10.0.0.10/8 dev p-h1
ip netns exec sv ip addr add 10.0.0.20/8 dev p-h2

ip netns exec cl ip link set p-h1 up
ip netns exec sv ip link set p-h2 up

ip netns exec cl ip link set lo up
ip netns exec sv ip link set lo up

ip link set p2-br up
ip link set p3-br up
ip link set bridge up
