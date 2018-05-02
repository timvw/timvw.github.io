---
id: 44
title: Brainteaser
date: 2006-01-14T02:59:45+00:00
author: timvw
layout: post
guid: http://www.timvw.be/brainteaser/
permalink: /2006/01/14/brainteaser/
tags:
  - PHP
---
Earlier today Chung Leong, an intelligent regular at [comp.lang.php](news://comp.lang.php), posted a little brainteaser:

> The two functions in the example below behave differently. The difference is easy to spot, of ocurse. The challenge is correctly explaining why this is so. Why does the second function seemingly corrupt the cloned copy of an object? 
 
```php
function BritneySpear(&$obj) {
$attr =& $obj->attributes;
$clone = /* clone */ $obj;
$obj->attributes[‘Length’] = 0;
$obj->data = “”;
return $clone;
}

$data = “This is a test”;
$obj1->attributes = array(‘Length’ => strlen($data));
$obj1->data = $data;
$clone1 = Bobcat($obj1);
print_r($clone1);

$obj2->attributes = array(‘Length’ => strlen($data));
$obj2->data = $data;
$clone2 = BritneySpear($obj2);
print_r($clone2);
?>
```
> 
>Result:
```php
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
```

It took me fifteen minutes to figure out the source of this mysterious behaviour, but it took me a couple of hours to come up with the following explanation: After $attr =& $obj->attributes in the BritneySpear function the container that holds this variables has is_ref=1. Any properties that are references to other variables, will remain references when $obj is copied into $clone as explained in [Object cloning](http://php.belnet.be/manual/en/language.oop5.cloning.php). 

If you want to know more about references i can advise you to read [PHP References](http://derickrethans.nl/files/phparch-php-variables-article.pdf) by [Derick Rethans](http://derickrethans.nl).
