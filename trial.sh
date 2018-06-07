#!/bin/bash
# ========================================
#           Original Script By            
#   Jajan Online - Whats App 08994422537  
# ========================================

username=trial-`</dev/urandom tr -dc X-Z0-9 | head -c4`
masaaktif="1"
password=`</dev/urandom tr -dc a-f0-9 | head -c9`
IP=`dig +short myip.opendns.com @resolver1.opendns.com`
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $username
echo -e "$Pass\n$Pass\n"|passwd $username &> /dev/null
echo -e ""
echo -e " ===================== Informasi Akun ===================== "
echo -e " Host           : $IP                                       "
echo -e " Port OpenSsh   : 22                                        "
echo -e " Port Dropbear  : 443                                       "
echo -e " Port Squid     : 80, 8080                                  "
echo -e " Config OpenVPN : http://$IP:81/1194-client.ovpn            "
echo -e " Username       : $username                                 "
echo -e " Password       : $password                                 "
echo -e " ========================================================== "
echo -e " Akun Aktif Hanya 1 Hari                                    "
echo -e " ========================================================== "
echo -e "                     Original Script by                     "
echo -e "            Jajan Online - Whats App 08994422537            "
echo -e " ========================================================== "