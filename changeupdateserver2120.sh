#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
ip_address=${1}
hardpassword=${2}
upgradehttpserver=${3}

$SCRIPTPATH/changeupdateserver1400.sh $ip_address $hardpassword $upgradehttpserver
