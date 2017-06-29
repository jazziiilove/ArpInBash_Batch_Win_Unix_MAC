#!/bin/bash
#static ARP record setting
#written by Baran Topal 17-09-2009
MAC=$(sudo arp -a | grep "139.179.33.1" | cut -d " " -f 4)
eval "sudo arp -i eth0 -s 139.179.33.1 ${MAC}"
