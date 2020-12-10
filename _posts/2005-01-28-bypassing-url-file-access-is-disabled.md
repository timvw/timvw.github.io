---
title: Bypassing URL file-access is disabled
layout: post
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
