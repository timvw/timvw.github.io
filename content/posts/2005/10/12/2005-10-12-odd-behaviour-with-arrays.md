---
date: "2005-10-12T00:00:00Z"
tags:
- PHP
title: Odd behaviour with arrays
---
A while ago i was really stumbled by the behaviour of a server. This problem solved itself after the sysadmin noticed that he forgot to upgrade [ionCube](http://www.ioncube.com/) after a php upgrade.Here is the code that i ran

```php
$array = array();
$array[] = array('name' => 'row1', 'value' => '1');
$array[] = array('name' => 'row2', 'value' => '3');
$array[] = array('name' => 'row3', 'value' => '2');

foreach($array as $row)
{    
  print_r($row);  
  echo '';
}
```

The expected output is

```php 
Array ( [name] => row1 [value] => 1 )
Array ( [name] => row2 [value] => 3 )
Array ( [name] => row3 [value] => 2 )
```

For some odd reason this is the output i got

```php  
Array ( [0] => Array ( [name] => row1 [value] => 1 ) [1] => 0 )
Array ( [0] => Array ( [name] => row2 [value] => 3 ) [1] => 1 )
```
