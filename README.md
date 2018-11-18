# RPi_Network_Tools
Hacky scripts I've knocked up and run on a RPi to monitor my home network

leaseConvert.sh takes the output of the dnsmasq dhcp lease table and pushes it into a html file so I can view devices on the network at any time

speed-csv.py is a python script to run a speed test and output the results to a CSV

plotSpeedTest.sh takes the output of speed-scv.py, seperates them into some temporary CSVs and then uses GNUplot to create charts based on them to provide a historic view of download speeds, upload speeds and ping response times.
