---
ID: 121
post_title: Introducing the masterpage
author: timvw
post_date: 2005-11-06 02:51:31
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/11/06/introducing-the-masterpage/
published: true
---
<p>Most websites have the same layout and an area with dynamic content. So most people choose for the following solution: generate a couple of template files for the static content and then write the code for the dynamic content and include the static templates. Here is how the code for a contact and an aboutme page would look like:</p>

<dl>
<dt>contact.php</dt>
<dd>
[code lang="php"]<?php
include('header.php');
include('leftpanel.php');
// code for contact page
include('rightpanel.php');
include('footer.php');
?>[/code]
</dd>
<dt>aboutme.php</dt>
<dd>
[code lang="php"]<?php
include('header.php');
include('leftpanel.php');
//something about me
include('rightpanel.php');
include('footer.php');
?>[/code]
</dd>
</dl>

<p>This code is pretty flexible. But what happens if you want to change your layout to something without a rightpanel? Right, you have to edit each page and remove the include call. A couple of weeks ago i discovered the concept of <a href="http://www.lifl.fr/~dumoulin/tiles/">tiles</a> and immediately realised this is useful for php too. Here is an example implementation:</p>

<dl>
<dt>contact.php</dt>
<dd>
[code lang="php"]<?php
require_once('init.php');
$tiles = array();
$tiles['main'] = PAGE_CONTENT . '/contact.html';
include('masterpage.php');
?>[/code]
</dd>
<dt>aboutme.php</dt>
<dd>
[code lang="php"]<?php
require_once('init.php');
$tiles = array();
$tiles['main'] = PAGE_CONTENT . '/aboutme.html';
include('masterpage.php');
?>[/code]
</dd>
<dt>masterpage.php</dt>
<dd>
[code lang="php"]<?php
if (!isset($tiles)) $tiles = array();
if (!isset($tiles['header']) $tiles['headers'] = PAGE_CONTENT . '/default-header.html';
if (!isset($tiles['leftpanel']) $tiles['headers'] = PAGE_CONTENT . '/default-leftpanel.html';
if (!isset($tiles['main']) $tiles['headers'] = PAGE_CONTENT . '/default-main.html';
if (!isset($tiles['footer']) $tiles['headers'] = PAGE_CONTENT . '/default-footer.html';
include($tiles['header']);
include($tiles['leftpanel']);
include($tiles['main']);
include($tiles['footer.php']);
?>[/code]
</dd>
</dl>

<p>
As you can see, this allows the programmer to change the layout in a single file, the masterpage. If a programmer wants to change the content of a specific area of a page all he has to do is change the $tiles array.</p>