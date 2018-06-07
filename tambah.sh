#!/bin/bash
# ========================================
#           Original Script By            
#   Jajan Online - Whats App 08994422537  
# ========================================

read -p "Isikan username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	read -p "Isikan password akun [$username]: " password
	read -p "Berapa hari akun [$username] aktif: " AKTIF
	
	expiredate=$(chage -l $username | grep "Account expires" | awk -F": " '{print $2}')
	today=$(date -d "$expiredate" +"%Y-%m-%d")
	expire=$(date -d "$today + $AKTIF days" +"%Y-%m-%d")
	chage -E "$expire" $username
	passwd -u $username
	useradd -M -N -s /bin/false -e $expire $username
clear

echo -e ""
echo -e " =============== Informasi Akun Diperpanjang ============== "
echo -e " Username       : $username                                 "
echo -e " Password       : $password                                 "
echo -e " ========================================================== "
echo -e " Aktif Sampai   : $expire                                   "
echo -e " ========================================================== "
echo -e " ========================================================== "
echo -e "                     Original Script by                     "
echo -e "            Jajan Online - Whats App 08994422537            "
echo -e " ========================================================== "
else
	echo "Username [$username] belum terdaftar!"
	exit 1
fi
