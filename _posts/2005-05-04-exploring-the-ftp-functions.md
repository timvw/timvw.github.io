---
id: 96
title: Exploring the FTP functions
date: 2005-05-04T01:35:25+00:00
author: timvw
layout: post
guid: http://www.timvw.be/exploring-the-ftp-functions/
permalink: /2005/05/04/exploring-the-ftp-functions/
tags:
  - PHP
---
I am still drowning in the work, and exams are coming close too, but i decided to blog something about the [FTP](http://www.php.net/ftp) functions in [PHP](http://www.php.net). The script will download all the files that are available on the remote server.

```php
// make sure we have time enough to execute this script
set_time_limit(1200);

// connect to the ftp server
$ftp = ftp_connect('ftp.scarlet.be');
ftp_login($ftp, 'anonymous', 'password');

// get the files that are available here
$local = glob('*.\*');

// get the files that are available there
$remote = ftp_nlist($ftp, '.');

// get the files there that are not availble here
foreach($remote as $file)
{  
  if (!in_array($file, $local))  
  {  
    // we do not have the file, thus download it  
    ftp_get($ftp, $file, $file, FTP_BINARY);  
  }
}

// close the connection
ftp_close($ftp);
```