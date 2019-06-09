#!/usr/bin/bash

ip netns add host1
ip netns add host2
ip netns add host3
ip netns add router

ip link add p-h1 type veth peer name p1-r
ip link add p-h2 type veth peer name p2-r
ip link add p-h3 type veth peer name p3-r

ip link set p-h1 netns host1
ip link set p-h2 netns host2
ip link set p-h3 netns host3
ip link set p1-r netns router
ip link set p2-r netns router
ip link set p3-r netns router

ip netns exec host1 ip addr add 192.168.100.10/24 dev p-h1
ip netns exec host2 ip addr add 192.168.110.10/24 dev p-h2
ip netns exec host3 ip addr add 192.168.200.10/24 dev p-h3
ip netns exec router ip addr add 192.168.100.1/24 dev p1-r
ip netns exec router ip addr add 192.168.110.1/24 dev p2-r
ip netns exec router ip addr add 192.168.200.1/24 dev p3-r

ip netns exec host1 ip link set p-h1 up
ip netns exec host1 ip link set lo up
ip netns exec host2 ip link set p-h2 up
ip netns exec host2 ip link set lo up
ip netns exec host3 ip link set p-h3 up
ip netns exec host3 ip link set lo up

ip netns exec router ip link set p1-r up
ip netns exec router ip link set p2-r up
ip netns exec router ip link set p3-r up
ip netns exec router ip link set lo up

ip netns exec host1 ip route add 192.168.110.0/24 via 192.168.100.1 dev p-h1
ip netns exec host1 ip route add 192.168.200.0/24 via 192.168.100.1 dev p-h1
ip netns exec host2 ip route add 192.168.100.0/24 via 192.168.110.1 dev p-h2
ip netns exec host2 ip route add 192.168.200.0/24 via 192.168.110.1 dev p-h2
ip netns exec host3 ip route add 192.168.100.0/24 via 192.168.200.1 dev p-h3
ip netns exec host3 ip route add 192.168.110.0/24 via 192.168.200.1 dev p-h3

ip netns exec router sysctl -w net.ipv4.ip_forward=1
