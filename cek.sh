#!/bin/bash
# ========================================
#           Original Script By            
#   Jajan Online - Whats App 08994422537  
# ========================================
echo ""
echo " ========================================================== "
echo "                      Daftar Akun Login                     "
echo " ========================================================== "
echo ""
data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo " ========================================================== ";
echo "                        Dropbear Login                      ";
echo " ========================================================== ";

for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
	USER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
	IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
	if [ $NUM -eq 1 ]; then
		echo "$PID - $USER - $IP";
	fi
done
echo "";

data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

echo " ========================================================== ";
echo "                        OpenSSH Login                       ";
echo " ========================================================== ";
for PID in "${data[@]}"
do
        #echo "check $PID";
        NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
        USER=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
        IP=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
        if [ $NUM -eq 1 ]; then
                echo "$PID - $USER - $IP";
        fi
done
echo "";
echo " ========================================================== ";
echo "                        OpenVPN Login                       ";
echo " ========================================================== ";
tail -f /etc/openvpn/server-vpn.log

echo " ========================================================== "
echo " Untuk kill user log in, gunakan command                    ";
echo " kill -9 (nomerid)                                          ";
echo " contoh : kill -9 28651                                     ";
echo " ========================================================== ";
echo "                     Original Script by                     ";
echo "            Jajan Online - Whats App 08994422537            ";
echo " ========================================================== ";
