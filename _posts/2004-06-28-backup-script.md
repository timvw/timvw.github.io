---
ID: 84
post_title: Backup script
author: timvw
post_date: 2004-06-28 00:55:15
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2004/06/28/backup-script/
published: true
---
<p>The current shell server i'm using returns bogus output for commands like df. Mind the negative value for 1-k blocks.</p>
<p>timvw@localhost:~$ df</p>
<table>
<tr>
<td>Filesystem</td>
<td>1k-blocks</td>
<td>Used</td>
<td>Available</td>
<td>Use%</td>
<td>Mounted on</td>
</tr>
<tr>
<td>/dev/hda1</td>
<td><b>-780429856382</b></td>
<td>1</td>
<td>0</td>
<td>74%</td>
<td>/</td>
</tr>
</table>
<p>It thought it would be a good idea to have a backup once in a while, but most of the times when i did it, i forgot to backup my database. So i wrote a little backup.script that remembers to do that for me.</p>
[code lang="bash"]
#!/bin/bash
###############################################################################
# Generate a backup file of homedirectory and database
# Author: Tim Van Wassenhove &lt;timvw@users.sourceforge.net&gt;
# Update: 2005-09-16 01:56:00
###############################################################################
# dump database
mysqldump -u username -ppassword -h invalid.org dbname &gt; ~/mysql.dmp

# generate gzipped archive of homedirectory
tar -czf /tmp/backup.tgz ~

# move backup to homedirectory and change name
mv /tmp/backup.tgz ~/madoka-`date +%F`.tgz

# remove database dump
rm ~/mysql.dmp
[/code]