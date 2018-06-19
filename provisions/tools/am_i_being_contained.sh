#!/bin/bash

# Fingerprint for some container tech
# TODO: Rewrite this in Go for better portablility and payload generation.

# TODO: Handle args
POSITIONAL=()
while [[ $# -gt 0 ]]; do
	key="$1"
	case $key in
		--check_for_docker_sock)
		CHECK_FOR_DOCKER_SOCK=1
		shift
		;;
		--exploit_docker_sock)
		EXPLOIT_DOCKER_SOCK=1
		shift # past arg
		;;
		-c|--check_cgroup)
		CHECK_CGROUP=1
		shift
		;;	
		-f|--find)
		RUN_FIND=1
		shift
		;;
		-m|--check_mac)
		CHECK_MAC=1
		shift
		;;
		--default)
		DEFAULT=1
		;;
	esac		
done
set -- "${POSITIONAL[@]}" # restore positional paramters
CF_GARDEN=0
LXD=0
FIND_RES=0

check_for_docker_sock () {
	echo "Checking for mounted docker socket >:)"
	RES=$(find "/" 2>&1 | grep -E "docker.sock")
	if [[ RES ]]; then
		echo -e "Found it!\n"
	else 
		echo -e "Couldn't locate the docker socket :(\n"
	fi
}

exploit_docker_sock () {
	echo -e "Not yet implemented.\n"
}

check_cgroup () {
	# TODO: explore more container tech to expand this check, if possible
	echo "Checking cgroup..."
	cat /proc/1/cgroup | grep -E ":/docker/|:/garden/"
	echo -e "\n"
}

run_find () {
	echo "Searching from / ..."
	$(find "/" 2>&1 | grep -E "docker|garden")
	echo -e "\n"
}

check_mac () {
	echo "Checking ETH0 mac address..."
	echo "WARNING: Unreliable check!"
	cat /sys/class/net/eth0/address
	echo -e "Not fully implemented.\n"
}

if [[ $DEFAULT ]]; then
	echo "Running in default mode... checking everything."
	check_for_docker_sock
	check_cgroup
	run_find
	check_mac
fi

if [[ $CHECK_FOR_DOCKER_SOCK ]]; then
	check_for_docker_sock
fi

if [[ $CHECK_CGROUP ]]; then
	check_cgroup
fi

if [[ $RUN_FIND ]]; then
	run_find
fi

if [[ $CHECK_MAC ]]; then
	check_mac
fi
