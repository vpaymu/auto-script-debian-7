#!/bin/bash
# Script Auto Installer by Jajan Online
# Whats App 08994422537

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

#detail nama perusahaan
country=ID
state=Jakarta
locality=Jakarta
organization=JajanOnline
organizationalunit=IT
commonname=JajanOnline
email=alchemy.2608@gmail.com

# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install wget and curl
apt-get update
apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# set repo
wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/sources.list.debian7"
wget "http://www.dotdeb.org/dotdeb.gpg"
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
wget -qO - http://www.webmin.com/jcameron-key.asc | apt-key add -

# update
apt-get update

# install webserver
apt-get -y install nginx

# install essential package
apt-get -y install nano iptables dnsutils openvpn screen whois ngrep unzip unrar

# install neofetch
echo "deb http://dl.bintray.com/dawidd6/neofetch jessie main" | sudo tee -a /etc/apt/sources.list
curl -L "https://bintray.com/user/downloadSubjectPublicKey?username=bintray" -o Release-neofetch.key && sudo apt-key add Release-neofetch.key && rm Release-neofetch.key
apt-get update
apt-get install neofetch

echo "clear" >> .bashrc
echo 'echo -e "\e[94m ========================================================== "' >> .bashrc
echo 'echo -e "\e[94m Selamat datang di server $HOSTNAME                         "' >> .bashrc
echo 'echo -e "\e[94m Script by Jajan Online, Whats App 08994422537              "' >> .bashrc
echo 'echo -e "\e[94m Ketik menu untuk menampilkan daftar perintah               "' >> .bashrc
echo 'echo -e "\e[94m ========================================================== "' >> .bashrc

# install webserver
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/nginx.conf"
mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/vps.conf"
service nginx restart

# install openvpn
wget -O /etc/openvpn/openvpn.tar "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/openvpn-debian.tar"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/1194.conf "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/1194.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -t nat -I POSTROUTING -s 192.168.100.0/8 -o eth0 -j MASQUERADE
iptables-save > /etc/iptables_yg_baru_dibikin.conf
wget -O /etc/network/if-up.d/iptables "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/iptables-restore"
chmod +x /etc/network/if-up.d/iptables
service openvpn restart

# konfigurasi openvpn
cd /etc/openvpn/
wget -O /etc/openvpn/client.ovpn "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/client-1194.conf"
sed -i $MYIP2 /etc/openvpn/client.ovpn;
cp client.ovpn /home/vps/public_html/

# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/badvpn-udpgw"
if [ "$OS" == "x86_64" ]; then
  wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/badvpn-udpgw64"
fi
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

# setting port ssh
cd
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
service ssh restart

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=109/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart

# install squid3
cd
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/squid3.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart

# install webmin
cd
apt-get -y install webmin
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
service webmin restart

# install stunnel
apt-get -y install stunnel4
wget -O /etc/stunnel/stunnel.pem "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/stunnel.pem"
wget -O /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/stunnel.conf"
sed -i $MYIP2 /etc/stunnel/stunnel.conf
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart

# install fail2ban
apt-get -y install fail2ban
service fail2ban restart

# install ddos deflate
cd
apt-get -y install dnsutils dsniff
wget https://github.com/vhandhu/auto-script-debian-7/raw/master/ddos-deflate-master.zip
unzip ddos-deflate-master.zip
cd ddos-deflate-master
./install.sh
rm -rf /root/ddos-deflate-master.zip

# download script
cd /usr/bin
wget -O menu "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/menu.sh"
wget -O buat "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/buat.sh"
wget -O tambah "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/tambah.sh"
wget -O trial "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/trial.sh"
wget -O hapus "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/hapus.sh"
wget -O expired "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/expired.sh"
wget -O expiredlist "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/expiredlist.sh"
wget -O cek "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/cek.sh"
wget -O member "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/member.sh"
wget -O resvis "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/resvis.sh"
wget -O limit "https://github.com/vhandhu/auto-script-debian-7/raw/master/limit.sh"
wget -O speedtest "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/speedtest_cli.py"
wget -O about "https://raw.githubusercontent.com/vhandhu/auto-script-debian-7/master/about.sh"
echo "cat /root/log-install.txt" | tee info

echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot

chmod +x menu
chmod +x buat
chmod +x tambah
chmod +x trial
chmod +x hapus
chmod +x expired
chmod +x expiredlist
chmod +x cek
chmod +x member
chmod +x resvis
chmod +x limit
chmod +x speedtest
chmod +x info
chmod +x about

# finishing
cd
chown -R www-data:www-data /home/vps/public_html
service nginx start
service openvpn restart
service cron restart
service ssh restart
service dropbear restart
service stunnel4 restart
service squid3 restart
service webmin restart
rm -rf ~/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile

# info
clear
echo -e "\e[94m ========================================================== "  | tee -a log-install.txt
echo -e "\e[94m Layanan yang diaktifkan                                    "  | tee -a log-install.txt
echo -e "\e[94m ========================================================== "  | tee -a log-install.txt
echo -e "\e[94m OpenVPN       : http://$MYIP:81/client.ovpn)               "  | tee -a log-install.txt
echo -e "\e[94m Port OpenSSH  : 22, 143                                    "  | tee -a log-install.txt
echo -e "\e[94m Port Dropbear : 109, 110, 443                              "  | tee -a log-install.txt
echo -e "\e[94m SquidProxy    : 80, 8080, 8888, 3128 (limit to IP SSH)     "  | tee -a log-install.txt
echo -e "\e[94m Nginx         : 81                                         "  | tee -a log-install.txt
echo -e "\e[94m badvpn        : badvpn-udpgw port 7300                     "  | tee -a log-install.txt
echo -e "\e[94m Webmin        : http://$MYIP:10000/                        "  | tee -a log-install.txt
echo -e "\e[94m vnstat        : http://$MYIP:81/vnstat/                    "  | tee -a log-install.txt
echo -e "\e[94m MRTG          : http://$MYIP:81/mrtg/                      "  | tee -a log-install.txt
echo -e "\e[94m Timezone      : Asia/Jakarta                               "  | tee -a log-install.txt
echo -e "\e[94m Fail2Ban      : [on]                                       "  | tee -a log-install.txt
echo -e "\e[94m IPv6          : [off]                                      "  | tee -a log-install.txt
echo -e "\e[94m ========================================================== "  | tee -a log-install.txt
echo -e "\e[94m Menu       : Menampilkan daftar perintah yang tersedia     "  | tee -a log-install.txt
echo -e "\e[94m Speedtest  : untuk cek speed vps                           "  | tee -a log-install.txt
echo -e "\e[94m Mem        : untuk melihat pemakaian ram                   "  | tee -a log-install.txt
echo -e "\e[94m Bench      : untuk melihat performa vps                    "  | tee -a log-install.txt
echo -e "\e[94m Buat       : untuk membuat akun baru                       "  | tee -a log-install.txt
echo -e "\e[94m Member     : untuk melihat daftar akun dan masa aktifnya   "  | tee -a log-install.txt
echo -e "\e[94m Limit      : untuk kill akun yang login lebih dari limit   "  | tee -a log-install.txt
echo -e "\e[94m              Contoh : limit 1                              "  | tee -a log-install.txt
echo -e "\e[94m Cek        : untuk melihat user yang sedang login          "  | tee -a log-install.txt
echo -e "\e[94m Expiredlist: untuk melihat daftar akun expired             "  | tee -a log-install.txt
echo -e "\e[94m Expired    : untuk menghapus user yang expired             "  | tee -a log-install.txt
echo -e "\e[94m Hapus      : untuk menghapus user                          "  | tee -a log-install.txt
echo -e "\e[94m Trial      : untuk membuat akun trial selama 1 hari        "  | tee -a log-install.txt
echo -e "\e[94m Tambah     : untuk memperpanjang masa aktif akun           "  | tee -a log-install.txt
echo -e "\e[94m Resvis     : untuk merestart dropbear dan squid            "  | tee -a log-install.txt
echo -e "\e[94m Info       : untuk melihat ulang informasi ini             "  | tee -a log-install.txt
echo -e "\e[94m About      : Informasi script                              "  | tee -a log-install.txt
echo -e "\e[94m ========================================================== "  | tee -a log-install.txt
cd
rm -f /root/debian7.sh
