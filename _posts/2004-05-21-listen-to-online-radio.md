---
ID: 77
post_title: Listen to online radio
author: timvw
post_date: 2004-05-21 00:40:28
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2004/05/21/listen-to-online-radio/
published: true
---
[code lang="bash"]
#!/bin/sh
#
# Author: Tim Van Wassenhove &lt;timvw@users.sourceforge.net&gt;
# Update: 2004-05-21 02:50:31
#
# This script allows you to listen to Belgian online radio streams.
#

if [ &quot;$1&quot; == &quot;&quot; ]; then
echo &quot;
[1]   Radio 1
[2]   Radio 2
[3]   Studio Brussel
[4]   Donna
[5]   4FM
[6]   QMusic
[7]   Topradio
[9]   Klara

Enter your choice: &quot;
read choice
else
choice=&quot;$1&quot;
fi

case &quot;$choice&quot; in
    1) station=&quot;mms://streampower.belgacom.be:1755/radio1high&quot; ;;
    2) station=&quot;mms://streampower.belgacom.be:1755/ra2vlbhigh&quot; ;;
    3) station=&quot;mms://streampower.belgacom.be:1755/stubruhigh&quot; ;;
    4) station=&quot;mms://streampower.belgacom.be:1755/donnahigh&quot; ;;
    5) station=&quot;mms://mss.streampower.be/4fmhi&quot; ;;
    6) station=&quot;mms://mss.streampower.be/qmusic_ahi&quot; ;;
    7) station=&quot;mms://mss.streampower.be/topahi&quot; ;;
    9) station=&quot;mms://streampower.belgacom.be:1755/stubruhigh&quot; ;;
    *) echo &quot;Wrong choice!&quot;
    exit
esac

mplayer $station

exit
[/code]