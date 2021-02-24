#!/bin/bash

ip_address=${1}
currentpassword=${2}
hardpassword=${3}

sid=$(curl -s -c /root/cookies.txt -d"password=$currentpassword" http://$ip_address/cgi-bin/dologin | grep sid | sed -r 's|.*"sid"[[:space:]]*: "([0-9a-z]+)".*|\1|' )
if [ ! -z $sid ]
then
  echo "OK Login ${1}"
  changepassword="P196=$hardpassword&:confirmUserPwd=$hardpassword&P2=$hardpassword&:confirmAdminPwd=$hardpassword&sid=${sid}"
  curl -b /tmp/cookies.txt -d"${changepassword}" http://${1}/cgi-bin/api.values.post
  applaycmd="cmd=extend&arg=&sid=${sid}"
  curl -s -X "POST" -b /tmp/cookies.txt -d"${applaycmd}" --header "Connection: keep-alive" \
    --header "Cache-Control: max-age=0" \
    --header "Origin: http://$ip_address" \
    --header "Referer: http://$ip_address/" \
    --header "ccept-Encoding: gzip, deflate" \
    --header "Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4" \
    --header "User-Agent: Chrome/58.0.3029.110 Safari/537.36" \
    "http://$ip_address/cgi-bin/api-phone_operation"

else
    echo "Wrong Password $ip_address"
fi
#curl -b /tmp/cookies.txt -d"request=REBOOT&sid=${sid}" http://${2}/cgi-bin/api-sys_operation
