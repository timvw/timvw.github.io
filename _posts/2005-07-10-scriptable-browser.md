---
ID: 103
post_title: Scriptable browser
author: timvw
post_date: 2005-07-10 02:00:05
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/07/10/scriptable-browser/
published: true
---
<p>Last couple of days i've been trying out <a href="http://www.lastcraft.com/simple_test.php">Simple Test</a>. It allowed me stop stop <a href="http://www.php.net/echo">echo</a> and <a href="http://www.php.net/print_r">print_r</a> variables all over the place. The package also has a <a href="http://www.lastcraft.com/browser_documentation.php">Scriptable Browser</a>.</p>

<p>At <a href="http://www.smscity.be">smscity.be</a> you can earn credits each day. Therefor you have to visit their site and click some links. I wrote a <a href="http://www.timvw.be/wp-content/code/php/smscity.txt">smscity.txt script</a> that does this for me.</p>

<p>Now all i had to do is make sure this script is executed each day, so i edited my <a href="http://unixhelp.ed.ac.uk/CGI/man-cgi?crontab+5">crontab</a>. It looks like:</p>

[code lang="php"]###############################################################################
#
# Author: Tim Van Wassenhove
#
###############################################################################
# $Id:
###############################################################################

  @reboot                               /usr/bin/fetchmail -d 1800
  0,10,20,30,40,50      *  *  *  *      /usr/bin/wget -O /dev/null http://timvw/cron/blogmarks.php &gt; /dev/null 2&gt;&amp;1
  30                   02  *  *  *      /usr/bin/wget -O /dev/null http://timvw/cron/smscity.php &gt; /dev/null 2&gt;&amp;1

# *                     *  *  *  *      *
# |                     |  |  |  |      |
# |                     |  |  |  |      +----- command to be executed
# |                     |  |  |  +------------ day of week (1 - 7) (monday = 1)
# |                     |  |  +--------------- month (1 - 12)
# |                     |  +------------------ day of month (1 - 31)
# |                     +--------------------- hour (0 - 23)
# +------------------------------------------- min (0 - 59)

[/code]