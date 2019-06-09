#!/usr/bin/bash

ip netns add router
ip netns add host1
ip netns add host2

ip link add p-rt type veth peer name p1-br
ip link add p-h1 type veth peer name p2-br
ip link add p-h2 type veth peer name p3-br

ip link set p-rt netns router
ip link set p-h1 netns host1
ip link set p-h2 netns host2

brctl addbr bridge
sleep 1
brctl addif bridge p1-br
brctl addif bridge p2-br
brctl addif bridge p3-br

ip netns exec router ip addr add 192.168.100.10/24 dev p-rt
ip netns exec host1 ip addr add 192.168.100.20/24 dev p-h1
ip netns exec host2 ip addr add 192.168.100.30/24 dev p-h2

ip netns exec router ip link set p-rt up
ip netns exec host1 ip link set p-h1 up
ip netns exec host2 ip link set p-h2 up

ip netns exec router ip link set lo up
ip netns exec host1 ip link set lo up
ip netns exec host2 ip link set lo up

ip link set p1-br up
ip link set p2-br up
ip link set p3-br up
ip link set bridge up
