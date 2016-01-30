---
ID: 44
post_title: Brainteaser
author: timvw
post_date: 2006-01-14 02:59:45
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/01/14/brainteaser/
published: true
---
<p>Earlier today Chung Leong, an intelligent regular at <a href="news://comp.lang.php">comp.lang.php</a>, posted a little brainteaser:</p>
<blockquote>

<p>
The two functions in the example below behave differently. The difference is easy to spot, of ocurse. The challenge is correctly explaining why this is so. Why does the second function
seemingly corrupt the cloned copy of an object?
</p>

[code lang="php"]<?php
// uncomment the clone operator for PHP 5

function Bobcat(&$obj) {
        $clone = /* clone */ $obj;
        $obj->attributes['Length'] = 0;
        $obj->data = "";
        return $clone;
}

function BritneySpear(&$obj) {
        $attr =& $obj->attributes;
        $clone = /* clone */ $obj;
        $obj->attributes['Length'] = 0;
        $obj->data = "";
        return $clone;
}

$data = "This is a test";
$obj1->attributes = array('Length' => strlen($data));
$obj1->data = $data;
$clone1 = Bobcat($obj1);
print_r($clone1);

$obj2->attributes = array('Length' => strlen($data));
$obj2->data = $data;
$clone2 = BritneySpear($obj2);
print_r($clone2);
?>[/code]

<pre>
Result:

stdClass Object
(
    [attributes] => Array
        (
            [Length] => 14
        )

    [data] => This is a test
)
stdClass Object
(
    [attributes] => Array
        (
            [Length] => 0
        )

    [data] => This is a test
)
</pre>
</blockquote>

<p>It took me fifteen minutes to figure out the source of this mysterious behaviour, but it took me a couple of hours to come up with the following explanation: After $attr =& $obj->attributes in the BritneySpear function the container that holds this variables has is_ref=1. Any properties that are references to other variables, will remain references when $obj is copied into $clone as explained in <a href="http://php.belnet.be/manual/en/language.oop5.cloning.php">Object cloning</a>. </p>

<p>If you want to know more about references i can advise you to read <a href="http://derickrethans.nl/files/phparch-php-variables-article.pdf">PHP References</a> by <a href="http://derickrethans.nl">Derick Rethans</a>.</p>