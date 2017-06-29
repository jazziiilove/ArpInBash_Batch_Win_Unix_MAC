#!/bin/bash
#static ARP record setting
#written by Baran Topal 17-09-2009
MAC=$(ifconfig en0 | grep "ether" | cut -d " " -f 2)
eval "arp -s 139.179.130.1 $MAC"
