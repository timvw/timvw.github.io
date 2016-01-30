---
ID: 58
post_title: GNU screen
author: timvw
post_date: 2006-02-06 21:31:58
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/02/06/gnu-screen/
published: true
---
<p>Another tool that belongs to my favorites is <a href="http://www.gnu.org/software/screen/">GNU Screen</a>. A couple of years ago i had a bad internet connection and when i was working on a remote shell i was always logged out and had to start over. I really hated that ;) Today i don't have this problem anymore, but i like to keep <a href="http://www.irssi.org">Irssi</a> (an <a href="http://en.wikipedia.org/wiki/IRC">IRC</a> user-agent) running, even when i'm not logged in. <a href="http://gentoo-wiki.com/TIP_Using_screen">TIP Using Screen</a> is an article that gives a couple of other reasons to use it and explains how it works. The default settings suck if you also use <a href="http://www.gnu.org/software/emacs/">GNU Emacs</a>. So i had to figure out a couple of keypresses. With "cat -v" i could easily see what those keypresses were. Here is my .screenrc file:</p>
<pre>
##############################################
# Author: Tim Van Wassenhove
# Update: 2006-02-06 03:02
##############################################
startup_message off
escape ^Oo

bind i screen -t 'irssi'        3 irssi
bind v screen -t 'vim'          4 vim
bind m screen -t 'mutt'         5 mutt
bind b screen -t 'slrn belnet'  6 slrn -h news.belnet.be
bind r screen -t 'slrn php'     7 slrn -h news.php.net
bind e screen -t 'elinks'       8 elinks http://www.google.com
</pre>