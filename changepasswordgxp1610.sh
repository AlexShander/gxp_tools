#!/bin/bash

hardpassword=${2}

sid=$(curl -s -c /tmp/cookies.txt -d"username=admin&password=admin" -H "Referer: http://${1}/" http://${1}/cgi-bin/dologin | grep sid |sed -r 's|.*"sid"+: "([0-9a-z]+)".*|\1|' )
echo $sid
if [ ! -z $sid ]
then
    echo "OK Login ${1}"
    changepassword="olduser=&P196=$hardpassword&:confirmUserPwd=$hardpassword&oldadmin=admin&P2=$hardpassword&:confirmAdminPwd=$hardpassword&sid=${sid}"
    curl -s -b /tmp/cookies.txt -v -d"${changepassword}" --header "Connection: keep-alive" \
--header "Cache-Control: max-age=0" \
--header "Origin: http://${1}" \
--header "Referer: http://${1}/" \
--header "ccept-Encoding: gzip, deflate" \
--header "Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4" \
--header "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36" \
  http://${1}/cgi-bin/api-change_password

else
    echo "Wrong Password ${1}"
fi
