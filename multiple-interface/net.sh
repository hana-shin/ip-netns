#!/usr/bin/bash

ip netns add cl
ip netns add sv

ip link add p0-sv type veth peer name p0-br
ip link add p1-cl type veth peer name p1-br
ip link add p2-cl type veth peer name p2-br
ip link add p3-cl type veth peer name p3-br

ip link set p0-sv netns sv
ip link set p1-cl netns cl
ip link set p2-cl netns cl
ip link set p3-cl netns cl

brctl addbr bridge
brctl addif bridge p0-br
brctl addif bridge p1-br
brctl addif bridge p2-br
brctl addif bridge p3-br

ip netns exec sv ip addr add 10.0.0.10/8 dev p0-sv
ip netns exec cl ip addr add 10.0.0.20/8 dev p1-cl
ip netns exec cl ip addr add 10.0.0.21/8 dev p2-cl
ip netns exec cl ip addr add 10.0.0.22/8 dev p3-cl

ip netns exec sv ip link set p0-sv up
ip netns exec cl ip link set p1-cl up
ip netns exec cl ip link set p2-cl up
ip netns exec cl ip link set p3-cl up

ip netns exec cl ip link set lo up
ip netns exec sv ip link set lo up

ip link set p0-br up
ip link set p1-br up
ip link set p2-br up
ip link set p3-br up
ip link set bridge up
