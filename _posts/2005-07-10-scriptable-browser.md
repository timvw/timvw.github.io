---
title: Scriptable browser
layout: post
tags:
  - PHP
---
Last couple of days i have been trying out [Simple Test](http://www.lastcraft.com/simple_test.php). It allowed me stop stop [echo](http://www.php.net/echo) and [print_r](http://www.php.net/print_r) variables all over the place. The package also has a [Scriptable Browser](http://www.lastcraft.com/browser_documentation.php).

At [smscity.be](http://www.smscity.be) you can earn credits each day. Therefor you have to visit their site and click some links. I wrote a [smscity.txt script](http://www.timvw.be/wp-content/code/php/smscity.txt) that does this for me.

Now all i had to do is make sure this script is executed each day, so i edited my [crontab](http://unixhelp.ed.ac.uk/CGI/man-cgi?crontab+5). It looks like:

```php
###############################################################################
# 
# # 
###############################################################################
# $###############################################################################
@reboot /usr/bin/fetchmail -d 1800 
0,10,20,30,40,50 \* \* \* \* /usr/bin/wget -O /dev/null http://timvw/cron/blogmarks.php > /dev/null 2>&1 
30 02 \* \* * /usr/bin/wget -O /dev/null http://timvw/cron/smscity.php > /dev/null 2>&1
# \* \* \* \* \* \* 
# | | | | | |
# | | | | | - command to be executed 
# | | | | --- day of week (1 - 7) (monday = 1) 
# | | | ----- month (1 - 12) 
# | | ------- day of month (1 - 31)
# | --------- hour (0 - 23) 
# ----------- min (0 - 59)
```
