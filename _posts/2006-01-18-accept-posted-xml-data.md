---
title: Accept posted XML data
layout: post
tags:
  - PHP
  - XML
---
I remember that i have spent a lot of time finding something that allowed me to accept the posted XML data. The solution was very simple

```php
$data = file_get_contents("php://input");
```
