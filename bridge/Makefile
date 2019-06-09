all:
	chmod 744 *.sh
	./net.sh
clean:
	ip -all netns del
	ip link set bridge down
	brctl delbr bridge
	ip l del test-br
