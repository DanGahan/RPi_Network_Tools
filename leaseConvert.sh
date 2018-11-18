#!/bin/bash
#Hacky script to print the output of the dnsmasq dhcp table into a html file
#Clear current file
> /var/www/html/index.html

echo "<html>" >> /var/www/html/index.html
echo "<Body>" >> /var/www/html/index.html

date >> /var/www/html/index.html
echo "<p>" >> /var/www/html/index.html
echo "<a href="http://192.168.0.254/speed.html">Speed test charts</a>" >> /var/www/html/index.html
echo "<p>" >> /var/www/html/index.html

awk 'BEGIN{print "<table>"} {print "<tr>";for(i=1;i<=NF;i++)print "<td>" $i"</td>";print "</tr>"} END{print "</table>"}' /var/lib/misc/dnsmasq.leases >> /var/www/html/index.html
echo "<p>" >> /var/www/html/index.html

cat staticIPs.txt >> /var/www/html/index.html
cat knownMACs.txt >> /var/www/html/index.html
echo "</Body>" >> /var/www/html/index.html

echo "</html>" >> /var/www/html/index.html