#!/bin/sh
#Script to chart the speed test CSV outputs from speed-csv.py
TEMPDIR=/tmp
SPEEDCSVWORKINGDIR=/home/dan
HTTPDDIR=/var/www/html

#Start by seperating download, upload and ping results into seperate CSVs
#Join the date and time columns into a single column in the new file

/usr/bin/awk -F "\"*,\"*" '{print $1 " " $2 "," $4 }' $SPEEDCSVWORKINGDIR/speedtest.csv > $TEMPDIR/down.csv
/bin/sed -i  1d $SPEEDCSVWORKINGDIR/down.csv

/usr/bin/awk -F "\"*,\"*" '{print $1 " " $2 "," $5 }' $SPEEDCSVWORKINGDIR/speedtest.csv > $TEMPDIR/up.csv
/bin/sed -i  1d $SPEEDCSVWORKINGDIR/up.csv

/usr/bin/awk -F "\"*,\"*" '{print $1 " " $2 "," $3 }' $SPEEDCSVWORKINGDIR/speedtest.csv > $TEMPDIR/ping.csv
/bin/sed -i  1d $SPEEDCSVWORKINGDIR/ping.csv

#Now use gnuplot to chart out the CSVs into 3 seperate charts and store them in the httpd html dir so can serve via webserver

/usr/bin/gnuplot -persist <<-EOFMarker
    set timefmt '%m/%d/%y %H:%M'
    set xdata time
    set datafile separator ","
    set xlabel "Date / Time"
    set ylabel "Mbps"
    set term png size 1000,320
    set output '$HTTPDDIR/down.png'
    plot '$TEMPDIR/down.csv' using 1:2 title 'Down' with lines
EOFMarker

/usr/bin/gnuplot -persist <<-EOFMarker
    set timefmt '%m/%d/%y %H:%M'
    set xdata time
    set datafile separator ","
    set xlabel "Date / Time"
    set ylabel "Mbps"
    set term png size 1000,320
    set output '$HTTPDDIR/up.png'
    plot '$TEMPDIR/up.csv' using 1:2 title 'Up' with lines
EOFMarker

/usr/bin/gnuplot -persist <<-EOFMarker
    set timefmt '%m/%d/%y %H:%M'
    set xdata time
    set datafile separator ","
    set xlabel "Date / Time"
    set ylabel "ms"
    set term png size 1000,320
    set output '$HTTPDDIR/ping.png'
    plot '$TEMPDIR/ping.csv' using 1:2 title 'Ping' with lines
EOFMarker