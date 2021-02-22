#!/bin/bash

ip_address=${1}
hardpassword=${2}
upgradehttpserver=${3}

sid=$(curl -s -c /tmp/cookies.txt -d"username=admin&password=$hardpassword" -H "Referer: http://$ip_address/" http://$ip_address/cgi-bin/dologin | grep sid |sed -r 's|.*"sid"+: "([0-9a-z]+)".*|\1|' )
echo $sid
if [ ! -z $sid ]
then
    echo "OK Login $ip_address"
    changeupgradesettings="P238=0&P194=3&P6767=1&P192=$upgradehttpserver&sid=${sid}"
    curl -s -b /tmp/cookies.txt -v -d"${changeupgradesetting}" --header "Connection: keep-alive" \
--header "Cache-Control: max-age=0" \
--header "Origin: http://$ip_address" \
--header "Referer: http://$ip_address/" \
--header "ccept-Encoding: gzip, deflate" \
--header "Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4" \
--header "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36" \
  http://$ip_address//cgi-bin/api.values.post

else
    echo "Wrong Password $ip_address"
fi
