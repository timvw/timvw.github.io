---
ID: 119
post_title: >
  a little hint for writing and testing a
  script
author: timvw
post_date: 2005-10-18 02:38:37
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/10/18/a-little-hint-for-writing-and-testing-a-script/
published: true
---
<p>I noticed that most people think Vim sucks and they constantly perform the following keystrokes:</p>
[code lang="dos"]
:wq
perl somefile.pl
vim somefile.pl
[/code]
<p>Here is the first trick, you don't need to exit vim to perform a command. Simply type the following while you're in vim:</p>
[code lang="dos"]
:!perl somefile.pl
[/code]
<p>Offcourse, you don't want to type the filename all the time, so you use the following:</p>
[code lang="dos"]
:!perl %
[/code]
<p>Now, if you are using a different scripting language it might be more portable to make the file executable (chmod u+x) and make sure the <a href="http://en.wikipedia.org/wiki/Shebang">Shebang</a> points to the right interpreter. Your script would be something like the following then:</p>
[code lang="perl"]
#!/usr/bin/env perl
use strict;
use warnings;
use Socket;
[/code]
<p>Now all you have to do is type the following in vim and your script will be executed:</p>
[code lang="dos"]
:!%
[/code]

<p>I noticed that the :!% trick doesn't work when your script is in your current working directory. This is how you can make it work:</p>
[code lang="dos"]
:!./%
[/code]
<p>I also noticed that before you execute this command you always need to type :w to save the changes. To automate this i've added the following to my ~/.vimrc file:</p>
[code lang="dos"]
map ,r :w&lt;cr&gt;:!./%&lt;/cr&gt;&lt;cr&gt;
&lt;/cr&gt;[/code]
<p>Now all i have to type is the following:</p>
[code lang="dos"]
,r
[/code]

<p>For other tricks and hints you have to check out <a href="http://www.vi-improved.org/tutorial.php">Vi-IMproved.org</a>.</p>