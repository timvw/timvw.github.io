---
date: "2006-01-18T00:00:00Z"
tags:
- PHP
- XML
title: Accept posted XML data
---
I remember that i have spent a lot of time finding something that allowed me to accept the posted XML data. The solution was very simple

```php
$data = file_get_contents("php://input");
```
