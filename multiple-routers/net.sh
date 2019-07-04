#!/usr/bin/bash

ip netns add cl
ip netns add r1
ip netns add r2
ip netns add r3
ip netns add sv

ip link add p0-cl type veth peer name p0-r1
ip link add p1-r1 type veth peer name p0-r2
ip link add p1-r2 type veth peer name p0-r3
ip link add p1-r3 type veth peer name p0-sv

ip link set p0-cl netns cl
ip link set p0-r1 netns r1
ip link set p1-r1 netns r1
ip link set p0-r2 netns r2
ip link set p1-r2 netns r2
ip link set p0-r3 netns r3
ip link set p1-r3 netns r3
ip link set p0-sv netns sv

ip netns exec cl ip addr add 192.168.10.10/24 dev p0-cl

ip netns exec r1 ip addr add 192.168.10.20/24 dev p0-r1
ip netns exec r1 ip addr add 192.168.20.10/24 dev p1-r1

ip netns exec r2 ip addr add 192.168.20.20/24 dev p0-r2
ip netns exec r2 ip addr add 192.168.30.10/24 dev p1-r2

ip netns exec r3 ip addr add 192.168.30.20/24 dev p0-r3
ip netns exec r3 ip addr add 192.168.40.10/24 dev p1-r3

ip netns exec sv ip addr add 192.168.40.20/24 dev p0-sv

ip netns exec cl ip link set p0-cl up
ip netns exec r1 ip link set p0-r1 up
ip netns exec r1 ip link set p1-r1 up
ip netns exec r2 ip link set p0-r2 up
ip netns exec r2 ip link set p1-r2 up
ip netns exec r3 ip link set p0-r3 up
ip netns exec r3 ip link set p1-r3 up
ip netns exec sv ip link set p0-sv up

ip netns exec cl ip link set lo up
ip netns exec r1 ip link set lo up
ip netns exec r2 ip link set lo up
ip netns exec r3 ip link set lo up
ip netns exec sv ip link set lo up

ip link set p0-cl up
ip link set p0-r1 up
ip link set p1-r1 up
ip link set p0-r2 up
ip link set p1-r2 up
ip link set p0-r3 up
ip link set p1-r3 up
ip link set p0-sv up
