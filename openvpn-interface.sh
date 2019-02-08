#!/usr/bin/env bash
set -e
set -u

version='1.0.0'
copyright="Copyright (c) 2019 Alexander O'Mara MPL-2.0"

usage () {
	echo "usage: $(basename "$0") ip_table_id ovpn_config_file [openvpn_arguments]"
}

usage_full () {
	usage
	echo
	echo "${version} - ${copyright}"
	echo
	echo "positional arguments:"
	echo "  ip_table_id          IP tables table ID to use"
	echo "  ovpn_config_file     The ovpn config file"
	echo "  openvpn_arguments    Optional additional openvpn arguments"
}

if [[ "$#" -gt 0 ]]; then
	if [[ "$1" == '-v' ]] || [[ "$1" == '--version' ]]; then
		echo "$version"
		exit 0
	fi
	if [[ "$1" == '-h' ]] || [[ "$1" == '--help' ]]; then
		usage_full
		exit 0
	fi
fi

if [[ "$#" -lt 2 ]]; then
	usage
	echo
	echo "ERROR: Requires 2 arguments"
	exit 1
fi

ip_table_id="$1"
shift
ovpn_config_file="$1"
shift

script_up=''
script_up+='ip route flush table "$1";'
script_up+='ip route add default via "${ifconfig_local}" dev "${dev}" table "$1";'
script_up+='ip rule add to "${ifconfig_local}" table "$1";'
script_up+='ip rule add from "${ifconfig_local}" table "$1"'

script_down=''
script_down+='ip route flush table "$1";'

bash_bin="$(which bash)"

exec openvpn \
	--pull-filter ignore redirect-gateway \
	--script-security 2 \
	--up "${bash_bin} -c '${script_up}' '' '${ip_table_id}'" \
	--down "${bash_bin} -c '${script_down}' '' '${ip_table_id}'" \
	--config "${ovpn_config_file}" \
	"$@"
