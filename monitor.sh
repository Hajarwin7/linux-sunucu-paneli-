#!/bin/bash

TARIH=$(date "+%d-%m-%Y %H:%M:%S")
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4 "%"}')
TOPLAM_RAM=$(free -m | awk 'NR==2{print $2}')
KULLANILAN_RAM=$(free -m | awk 'NR==2{print $3}')
DISK=$(df -h / | awk 'NR==2{print $3 " / " $2 " (" $5 ")"}')
KULLANICI=$(who | wc -l)

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sunucu Durum Paneli</title>
</head>
<body>

<h1>Linux Sunucu Durum Paneli</h1>
<hr>

<table border="1" cellpadding="8">
<tr>
    <th>Bilgi</th>
    <th>Değer</th>
</tr>

<tr>
    <td>Rapor Saati</td>
    <td>$TARIH</td>
</tr>

<tr>
    <td>CPU Kullanımı</td>
    <td>$CPU</td>
</tr>

<tr>
    <td>RAM Kullanımı</td>
    <td>$KULLANILAN_RAM MB / $TOPLAM_RAM MB</td>
</tr>

<tr>
    <td>Disk Kullanımı</td>
    <td>$DISK</td>
</tr>

<tr>
    <td>Aktif Kullanıcı Sayısı</td>
    <td>$KULLANICI</td>
</tr>

</table>

</body>
</html>
EOF

