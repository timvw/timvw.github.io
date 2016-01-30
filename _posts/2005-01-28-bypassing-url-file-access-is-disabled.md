---
ID: 92
post_title: Bypassing URL file-access is disabled
author: timvw
post_date: 2005-01-28 01:18:19
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/01/28/bypassing-url-file-access-is-disabled/
published: true
dsq_thread_id:
  - "1923053113"
---
<p>For some odd reason this host has disabled URL file-access.
So i needed something simple to bypass this problem:</p>
[code lang="php"]
function fetch_url($url)
{
    if (preg_match("#^http://(.*?)/(.*)$#", $url, $matches))
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
            if (preg_match("#^Content-Type: .*?\r\n$#", $read))
            {
                $ignore = false;
            }
        }
        fclose($fp);
        return $contents;
    }
}
[/code]