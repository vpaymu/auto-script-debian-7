#!/bin/bash
# ========================================
#           Original Script By            
#   Jajan Online - Whats App 08994422537  
# ========================================

service dropbear stop
service dropbear start
service stunnel4 restart
service webmin restart
service php5-fpm restart
service nginx restart
service squid3 restart
service openvpn restart
service ssh restart
service openvpn status
