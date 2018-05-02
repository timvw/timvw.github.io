---
id: 115
title: Using cmd.exe
date: 2006-04-01T02:30:07+00:00
author: timvw
layout: post
guid: http://www.timvw.be/using-cmdexe/
permalink: /2006/04/01/using-cmdexe/
tags:
  - PHP
---
Earlier someone asked me how he could use [windows cmd.exe](http://www.microsoft.com/resources/documentation/windows/xp/all/proddocs/en-us/cmd.mspx?mfr=true) with PHP. People run into trouble as soon as there are quotes needed because there are special characters (>/&()[]{}^=;!'+,\`~ and <space>) in the command. I do it like this

```php
<?php
$result = `""c:\\my path\\prog.exe" "filename""`;
?>
```

In case you have to do it often you might want to wrap it into a little function like this

```php
<?php
function cmd($command, $arguments = null)
{
        $commandline = '';
        foreach(func_get_args() as $word) {
                $commandline .= '"' . $word . '" ';
        }
        $commandline = rtrim($commandline, ' ');
        $commandline = '"' . $commandline . '"';
        return `$commandline`;
}

// run blah.exe
cmd('blah.exe');

// run c:\my path\blah.exe with the arguments "foo" and "bar bar"
cmd('c:\\my path\\blah.exe', 'foo', 'bar bar');
?>
```
