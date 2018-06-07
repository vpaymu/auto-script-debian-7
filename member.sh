#!/bin/bash
# ========================================
#           Original Script By            
#   Jajan Online - Whats App 08994422537  
# ========================================
echo ""
echo "=========================================================== "
echo "                         Daftar Akun                        "
echo "=========================================================== "
echo ""
echo "=========================================================== "
echo "USERNAME        TANGGAL EXPIRED                             "
echo "=========================================================== "
while read expired
do
        AKUN="$(echo $expired | cut -d: -f1)"
        ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
        exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
        if [[ $ID -ge 500 ]]; then
        printf "%-17s %2s\n" "$AKUN" "$exp"
		fi
done < /etc/passwd

JUMLAH="$(awk -F: '$3 >= 500 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

echo "=========================================================== "
echo "Jumlah akun: $JUMLAH user"
echo "=========================================================== "
echo ""
echo "=========================================================== "
echo "                     Original Script by                     "
echo "            Jajan Online - Whats App 08994422537            "
echo "=========================================================== "

