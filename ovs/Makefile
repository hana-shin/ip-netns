all:
        chmod 744 *.sh
        ./net.sh
clean:
        ip -all netns del
        ovs-vsctl del-port ovs1 p1-ovs1
        ovs-vsctl del-port ovs1 p2-ovs1
        ovs-vsctl del-port ovs2 p1-ovs2
        ovs-vsctl del-port ovs2 p2-ovs2
        ovs-vsctl del-br ovs1
        ovs-vsctl del-br ovs2
