#!/bin/bash

ip_address=${1}
hardpassword=${2}
localsipport=${3}
localrtpport=50${localsipport:3:3}


sid=$(curl -s -c /tmp/cookies.txt -d"username=admin&password=$hardpassword" -H "Referer: http://$ip_address/" http://$ip_address/cgi-bin/dologin | grep sid |sed -r 's|.*"sid"+: "([0-9a-z]+)".*|\1|' )
if [ ! -z $sid ]
then
    echo "OK Login $ip_address"
    changeupgradesettings="P32=5&P2397=1&P40=$localsipport&P2347=1&P57=8&P58=18&P59=0&P60=8&P61=8&P62=8&P46=8&P191=0&P39=$localrtpport&P64=TZV-6&P143=0&P122=1&P1310=1&P1565=2&P1362=ru&sid=${sid}"
    curl -s -X "POST" -b /tmp/cookies.txt -d"${changeupgradesettings}" --header "Connection: keep-alive" \
      --header "Cache-Control: max-age=0" \
      --header "Origin: http://$ip_address" \
      --header "Referer: http://$ip_address/" \
      --header "ccept-Encoding: gzip, deflate" \
      --header "Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4" \
      --header "User-Agent: Chrome/58.0.3029.110 Safari/537.36" \
      "http://$ip_address/cgi-bin/api.values.post"
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
