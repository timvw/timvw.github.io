---
title: Introducing the masterpage
layout: post
tags:
  - PHP
---
Most websites have the same layout and an area with dynamic content. So most people choose for the following solution: generate a couple of template files for the static content and then write the code for the dynamic content and include the static templates. Here is how the code for a contact and an aboutme page would look like

contact.php
```php
<?php
include('header.php');
include('leftpanel.php');
// code for contact page
include('rightpanel.php');
include('footer.php');
?>
``` 

aboutme.php
```php
<?php
include('header.php');
include('leftpanel.php');
//something about me
include('rightpanel.php');
include('footer.php');
?>
``` 

This code is pretty flexible. But what happens if you want to change your layout to something without a rightpanel? Right, you have to edit each page and remove the include call. A couple of weeks ago i discovered the concept of [tiles](http://www.lifl.fr/~dumoulin/tiles/) and immediately realised this is useful for php too. Here is an example implementation

contact.php
```php
<?php
require_once('init.php');
$tiles = array();
$tiles['main'] = PAGE_CONTENT . '/contact.html';
include('masterpage.php');
?>
``` 

aboutme.php
```php
<?php
require_once('init.php');
$tiles = array();
$tiles['main'] = PAGE_CONTENT . '/aboutme.html';
include('masterpage.php');
?>
``` 

masterpage.php
```php
<?php
if (!isset($tiles)) $tiles = array();
if (!isset($tiles['header']) $tiles['headers'] = PAGE_CONTENT . '/default-header.html';
if (!isset($tiles['leftpanel']) $tiles['headers'] = PAGE_CONTENT . '/default-leftpanel.html';
if (!isset($tiles['main']) $tiles['headers'] = PAGE_CONTENT . '/default-main.html';
if (!isset($tiles['footer']) $tiles['headers'] = PAGE_CONTENT . '/default-footer.html';
include($tiles['header']);
include($tiles['leftpanel']);
include($tiles['main']);
include($tiles['footer.php']);
?>
``` 

As you can see, this allows the programmer to change the layout in a single file, the masterpage. If a programmer wants to change the content of a specific area of a page all he has to do is change the $tiles array.
