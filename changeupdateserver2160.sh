#!/bin/bash

ip_address=${1}
hardpassword=${2}
upgradehttpserver=${3}

sid=$(curl -s -c /tmp/cookies.txt -d"username=admin&password=$hardpassword" -H "Referer: http://$ip_address/" http://$ip_address/cgi-bin/dologin | grep sid |sed -r 's|.*"sid"[[:space:]]*: "([0-9a-z]+)".*|\1|' )
if [ ! -z $sid ]
then
    echo "OK Login $ip_address"
    changeupgradesettings="P238=0&P194=3&P6767=1&P192=$upgradehttpserver&sid=${sid}"
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
