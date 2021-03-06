#!/bin/bash

# Copyright © 2018 Christian Friedli <christian.friedli@id.unibe.ch>
#
# This module is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This software is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <http://www.gnu.org/licenses/>.


PLUGIN_FILENAME=${0##*/}
PLUGIN_DIR=$(dirname "$0")

ERROR_STATE=$STATE_CRITICAL
ERROR_STATE_LABEL="ERROR"


usage() {
    cat <<EOF
Usage: $PLUGIN_FILENAME [-h] EXPECTED_TIMEZONE

Optional arguments:
  -h, --help             Show this help message and exit

Required arguments:
  EXPECTED_TIMEZONE      Expected timezone (to get a list of valid timezones,
                         call 'timedatectl list-timezones')

EOF
}


parse_arguments() {
    local args=( "$@" )

    local temp
    temp=$(getopt --name "$PLUGIN_FILENAME"  --options "hw" --longoptions "help,warning" -- "${args[@]:-}")
    eval set -- "$temp"
    while true; do
	case "$1" in
	    --)
		shift
		break
		;;
	    *)
		usage
		exit $STATE_UNKNOWN
		;;
	esac
    done

    if [[ $# -ne 1 ]]; then
	usage
	exit $STATE_UNKNOWN
    fi

    EXPECTED_TIMEZONE=$1
    if [[ -z "$EXPECTED_TIMEZONE" ]]; then
	usage
	exit $STATE_UNKNOWN
    fi
}


check_timezone() {
   # Get current timezone
   if ! [[ -L /etc/localtime ]]; then
       echo "Unable to retrieve current timezone"
       exit $STATE_UNKNOWN
   fi

   localtime=$(realpath /etc/localtime)
   current_timezone=${localtime#*/zoneinfo/}
   if [[ "$current_timezone" != "$EXPECTED_TIMEZONE" ]]; then
       echo "1:1: Error: Current timezone is $current_timezone (expected timezone: $EXPECTED_TIMEZONE)"
       exit
   fi

   echo "0:0: OK: Current timezone is $EXPECTED_TIMEZONE"
}


parse_arguments "$@"
check_timezone
