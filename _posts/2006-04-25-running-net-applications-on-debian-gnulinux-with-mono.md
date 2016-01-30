---
ID: 29
post_title: >
  Running .NET applications on Debian
  GNU/Linux with Mono
author: timvw
post_date: 2006-04-25 02:40:04
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/04/25/running-net-applications-on-debian-gnulinux-with-mono/
published: true
dsq_thread_id:
  - "1920134121"
---
<p>Today i noticed <a href="http://www.linux.com/article.pl?sid=06/04/12/1921225">Running .Net applications on Linux with Mono</a> and the author wrote the following:</p>
<blockquote><p>
I found that on Debian at this stage I got an error: The assembly mscorlib.dll was not found or could not be loaded. It should have been installed in the '/usr/lib/mono/2.0/mscorlib.dll' directory. I cured that by executing:
$ cd /usr/lib/mono
$ sudo ln -s 1.0 2.0
</p></blockquote>
<p>There is only one error, and it's in the <a href="en.wikipedia.org/wiki/PEBKAC">PEBKAC</a> category. I can understand that the author couldn't find the TargetFrameworkVersion tag in his project file and generated 2.0 code. What i don't understand is that he didn't notice the <a href="http://www.mono-project.com/Downloads">Other Downloads</a> section and that there are <a href="http://www.debian.org">Debian</a> packages available with support for the 2.0 runtime. Ok, apt-get might complain about the packages and you would have to add a key to your keyring as following before you can install the packages:</p>
[code lang="dos"]
gpg --recv-keys 7127E5ABEEF946C8
gpg --armor --export 7127E5ABEEF946C8 | apt-key add -
[/code]
<p>How hard is that? :P</p>