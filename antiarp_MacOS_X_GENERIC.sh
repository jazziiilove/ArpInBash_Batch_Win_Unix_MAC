#!/bin/bash
#static ARP record setting
#written by Baran Topal 17-09-2009
MAC=$(arp -a  | grep "139.179.130.1" | cut -d " " -f 4)
eval "arp -s 139.179.130.1 $MAC"
