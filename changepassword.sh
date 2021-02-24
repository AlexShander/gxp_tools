#!/bin/bash
# Find all GPX with Asterisk CLI if you use chan_sip and not chan_pjsip

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
hardpassword=${1}

asterisk -rx 'sip show peers' | grep OK |cut -d '/' -f1| awk '{print $1}'| while IFS='' read -r line || [[ -n "$line" ]]; do  
  phone=$(asterisk -rx "sip show peer $line"| grep Useragent | grep GXP)
  if [ ! -z "$phone" ]
    then
      ipaddress=$(asterisk -rx "sip show peer $line"| grep 'Reg. Contact'  | cut -d \@ -f2 | cut -d \: -f1)
      echo $ipaddress
      if [[ "$phone" =~ ".*GXP2160.*" ]]
       then
         echo "Trying change password on $phone - $ipaddress"
         $SCRIPTPATH/changepasswordgxp2160.sh $ipaddress $hardpassword
      elif [[ "$phone" =~ ".*GXP1400.*" ]]
        then
          echo "Trying change password on $phone - $ipaddress"
          $SCRIPTPATH/changepasswordgxp1400.sh $ipaddress $hardpassword
       elif [[ "$phone" =~ ".*GXP2120.*" ]]
         then
           echo "Trying change password on $phone - $ipaddress"
           $SCRIPTPATH/changepasswordgxp1400.sh $ipaddress $hardpassword
       elif [[ "$phone" =~ ".*GXP2160.*" ]]
         then
           echo "Trying change password on $phone - $ipaddress"
           $SCRIPTPATH/changepasswordgxp1610.sh $ipaddress admin $hardpassword
       else
         echo "UNKNOW MODEL is $phone - $ipaddress"
       fi
  fi
done

