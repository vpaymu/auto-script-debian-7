#!/bin/bash
# Script restart service dropbear, webmin, squid3, openvpn, openssh
# Created by Bustami Arifin
service dropbear restart
service stunnel4 restart
service webmin restart
service php5-fpm restart
service nginx restart
service squid3 restart
service openvpn restart
service ssh restart
service openvpn status
