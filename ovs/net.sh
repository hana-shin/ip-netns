#!/usr/bin/bash

ip netns add host1
ip netns add host2

ovs-vsctl add-br ovs1
ovs-vsctl add-br ovs2

ip link add p-h1 type veth peer name p1-ovs1
ip link add p-h2 type veth peer name p1-ovs2
ip link add p2-ovs1 type veth peer name p2-ovs2

ip link set p-h1 netns host1
ip link set p-h2 netns host2

ovs-vsctl add-port ovs1 p1-ovs1 tag=10
ovs-vsctl add-port ovs2 p1-ovs2 tag=10

ovs-vsctl add-port ovs1 p2-ovs1
ovs-vsctl add-port ovs2 p2-ovs2

ip link set p1-ovs1 up
ip link set p2-ovs1 up
ip link set p1-ovs2 up
ip link set p2-ovs2 up

ip netns exec host1 ip link set p-h1 up
ip netns exec host2 ip link set p-h2 up
ip netns exec host1 ip link set lo up
ip netns exec host2 ip link set lo up

ip netns exec host1 ip addr add 192.168.100.10/24 dev p-h1
ip netns exec host2 ip addr add 192.168.100.20/24 dev p-h2
