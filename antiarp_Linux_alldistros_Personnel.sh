#!/bin/bash
#static ARP record setting
#written by Baran Topal 17-09-2009
MAC=$(sudo /sbin/ifconfig eth0 | grep "HWaddr" | cut -d " " -f 11)
eval "sudo arp -i eth0 -s 139.179.130.1 ${MAC}"
