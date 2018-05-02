---
id: 92
title: Bypassing URL file-access is disabled
date: 2005-01-28T01:18:19+00:00
author: timvw
layout: post
guid: http://www.timvw.be/bypassing-url-file-access-is-disabled/
permalink: /2005/01/28/bypassing-url-file-access-is-disabled/
dsq_thread_id:
  - 1923053113
tags:
  - PHP
---
For some odd reason this host has disabled URL file-access.
  
So i needed something simple to bypass this problem:

```php
function fetch_url($url)
{     
  if (preg_match("#^http://(.\*?)/(.\*)$#", $url, $matches))    
  {
    $host = $matches[1];       
    $uri = $matches[2];       
    $msg = "GET /$uri HTTP/1.0\r\nHost: $host\r\n\r\n";
    $fp = fsockopen($host, 80, $errno, $errstr, 10);
    fwrite($fp, $msg);         
    $ignore = true;        
    while (!feof($fp))        
    {            
      $read = fgets($fp, 1024);
      if (!$ignore)            
      {     
        $contents .= $read;            
      }
      if (preg_match("^Content-Type: .*?\r\n", $read))          
      {                
        $ignore = false;          
      }        
    }
    fclose($fp);
    return $contents;    
  }
}
```
