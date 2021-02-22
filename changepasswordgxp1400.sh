#!/bin/bash

hardpassword=${2}

sid=$(curl -s -c /root/cookies.txt -d"password=admin" http://${1}/cgi-bin/dologin | grep sid |sed -r 's|.*"sid" : "([0-9a-z]+)".*|\1|' )
if [ ! -z $sid ]
then
    echo "OK Login ${1}"
    changepassword="P196=$hardpassword&:confirmUserPwd=$hardpassword&P2=$hardpassword&:confirmAdminPwd=$hardpassword&sid=${sid}"
    curl -b /tmp/cookies.txt -d"${changepassword}" http://${1}/cgi-bin/api.values.post
else
    echo "Wrong Password ${1}"
fi
#curl -b /tmp/cookies.txt -d"request=REBOOT&sid=${sid}" http://${2}/cgi-bin/api-sys_operation
