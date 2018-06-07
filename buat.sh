#!/bin/bash
# ========================================
#           Original Script By            
#   Jajan Online - Whats App 08994422537  
# ========================================

# get the VPS IP
#ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
if [ "$MYIP" = "" ]; then
	MYIP=$(wget -qO- ipv4.icanhazip.com)
fi
#MYIP=$(wget -qO- ipv4.icanhazip.com)

echo ""
echo " ========================================================== "
echo "                        Membuat Akun                        "
echo " ========================================================== "
echo ""
read -p "Isikan username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo "Username [$username] sudah ada!"
	exit 1
else
	read -p "Isikan password akun [$username]: " password
	read -p "Berapa hari akun [$username] aktif: " AKTIF
	
	today="$(date +"%Y-%m-%d")"
	expire=$(date -d "$AKTIF days" +"%Y-%m-%d")
	useradd -M -N -s /bin/false -e $expire $username
	echo $username:$password | chpasswd
clear
echo -e ""
echo -e " ===================== Informasi Akun ===================== "
echo -e " Host           : $MYIP                                     "
echo -e " Port OpenSsh   : 22                                        "
echo -e " Port Dropbear  : 443                                       "
echo -e " Port Squid     : 80, 8080                                  "
echo -e " Config OpenVPN : http://$MYIP:81/1194-client.ovpn          "
echo -e " Username       : $username                                 "
echo -e " Password       : $password                                 "
echo -e " ========================================================== "
echo -e " Aktif Sampai   : $expire                                   "
echo -e " ========================================================== "
echo -e "                     Original Script by                     "
echo -e "            Jajan Online - Whats App 08994422537            "
echo -e " ========================================================== "
echo -e ""
fi
