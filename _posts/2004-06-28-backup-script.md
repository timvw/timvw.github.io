---
title: Backup script
layout: post
tags:
  - Bash
---
The current shell server i am using returns bogus output for commands like df. Mind the negative value for 1-k blocks.

timvw@localhost:~$ df

<table>
  <tr>
    <td>
      Filesystem
    </td>
    
    <td>
      1k-blocks
    </td>
    
    <td>
      Used
    </td>
    
    <td>
      Available
    </td>
    
    <td>
      Use%
    </td>
    
    <td>
      Mounted on
    </td>
  </tr>
  
  <tr>
    <td>
      /dev/hda1
    </td>
    
    <td>
      <b>-780429856382</b>
    </td>
    
    <td>
      1
    </td>
    
    <td>
    </td>
    
    <td>
      74%
    </td>
    
    <td>
      /
    </td>
  </tr>
</table>

It thought it would be a good idea to have a backup once in a while, but most of the times when i did it, i forgot to backup my database. So i wrote a little backup.script that remembers to do that for me.

```bash  
#!/bin/bash
############################################################################### 
# Generate a backup file of homedirectory and database
# # Up###############################################################################
# dump database
mysqldump -u username -ppassword -h invalid.org dbname > ~/mysql.dmp

# generate gzipped archive of homedirectory
tar -czf /tmp/backup.tgz ~

# move backup to homedirectory and change name
mv /tmp/backup.tgz ~/madoka-\`date +%F\`.tgz

# remove database dump
rm ~/mysql.dmp
```
