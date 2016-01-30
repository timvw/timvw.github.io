---
ID: 109
post_title: Odd behaviour with arrays
author: timvw
post_date: 2005-10-12 02:10:37
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/10/12/odd-behaviour-with-arrays/
published: true
---
<p>A while ago i was really stumbled by the behaviour of a server. This problem solved itself after the sysadmin noticed that he forgot to upgrade <a href="http://www.ioncube.com/">ionCube</a> after a php upgrade.Here is the code that i ran:</p>
[code lang="php"]
$array = array();
$array[] = array('name' => 'row1', 'value' => '1');
$array[] = array('name' => 'row2', 'value' => '3');
$array[] = array('name' => 'row3', 'value' => '2');

foreach($array as $row)
{
  print_r($row);
  echo "<br />";
}
[/code]
<p>The expected output is:</p>
[code lang="php"]
Array ( [name] => row1 [value] => 1 )
Array ( [name] => row2 [value] => 3 )
Array ( [name] => row3 [value] => 2 )
[/code]
<p>For some odd reason this is the output i got:</p>
[code lang="php"]
Array ( [0] => Array ( [name] => row1 [value] => 1 ) [1] => 0 )
Array ( [0] => Array ( [name] => row2 [value] => 3 ) [1] => 1 )
[/code]