#!/bin/bash

hardpassword=${2}

sid=$(curl -s -c /root/cookies.txt -d"username=admin&password=admin" http://${1}/cgi-bin/dologin | grep sid |sed -r 's|.*"sid"+: "([0-9a-z]+)".*|\1|' )
if [ ! -z $sid ]
then
    echo "OK Login ${1}"
    changepassword="olduser=&P196=$hardpassword&:confirmUserPwd=$hardpassword&oldadmin=admin&P2=$hardpassword&:confirmAdminPwd=$hardpassword&sid=${sid}"
    curl -b /tmp/cookies.txt -d"${changepassword}" http://${1}/cgi-bin/api-change_password
else
    echo "Wrong Password ${1}"
fi
