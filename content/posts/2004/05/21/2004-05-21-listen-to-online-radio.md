---
date: "2004-05-21T00:00:00Z"
tags:
- Bash
title: Listen to online radio
---
```bash
#!/bin/sh
#
# # Up# 
# This script allows you to listen to Belgian online radio streams.  
#

if [ "$1" == "" ]; then 
echo "
[1] Radio 1
[2] Radio 2
[3] Studio Brussel
[4] Donna
[5] 4FM
[6] QMusic
[7] Topradio 
[9] Klara
Enter your choice: "
read choice  
else
choice="$1"
fi

case "$choice" in
1) station="mms://streampower.belgacom.be:1755/radio1high" ;;
2) station="mms://streampower.belgacom.be:1755/ra2vlbhigh" ;;
3) station="mms://streampower.belgacom.be:1755/stubruhigh" ;;    
4) station="mms://streampower.belgacom.be:1755/donnahigh" ;;    
5) station="mms://mss.streampower.be/4fmhi" ;;    
6) station="mms://mss.streampower.be/qmusic_ahi" ;;  
7) station="mms://mss.streampower.be/topahi" ;;     
9) station="mms://streampower.belgacom.be:1755/stubruhigh" ;;  
*) echo "Wrong choice!"    
exit
esac

mplayer $station

exit
```
