---
ID: 96
post_title: Exploring the FTP functions
author: timvw
post_date: 2005-05-04 01:35:25
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/05/04/exploring-the-ftp-functions/
published: true
---
<p>I'm still drowning in the work, and exams are coming close too, but i decided to blog something about the <a href="http://www.php.net/ftp">FTP</a> functions in <a href="http://www.php.net">PHP</a>. The script will download all the files that are available on the remote server.<br /></p>
[code lang="php"]// make sure we have time enough to execute this script
set_time_limit(1200);

// connect to the ftp server
$ftp = ftp_connect('ftp.scarlet.be');
ftp_login($ftp, 'anonymous', 'password');

// get the files that are available here
$local = glob('*.*');

// get the files that are available there
$remote = ftp_nlist($ftp, '.');

// get the files there that are not availble here
foreach($remote as $file)
{
  if (!in_array($file, $local))
  {
    // we don't have the file, thus download it
    ftp_get($ftp, $file, $file, FTP_BINARY);
  }
}

// close the connection
ftp_close($ftp);
[/code]