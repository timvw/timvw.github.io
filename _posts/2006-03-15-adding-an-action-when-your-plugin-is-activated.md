---
id: 35
title: Adding an action when your plugin is activated
date: 2006-03-15T02:47:58+00:00
author: timvw
layout: post
guid: http://www.timvw.be/adding-an-action-when-your-plugin-is-activated/
permalink: /2006/03/15/adding-an-action-when-your-plugin-is-activated/
tags:
  - WordPress
---
The WordPress documentation says that you have to call add_action('activate_pluginurl', 'somefunction') to trigger somefunction when your plugin is activated. Unfortunately i couldn't find with what pluginurl should be replaced. After a bit of experimenting i've found that in wp-admin/plugins.php the following is called when a plugin is activated:

```php
do_action('activate_' . trim( $_GET['plugin'] ));
```

So it appears that you simply have to use the path of your plugin relative to /wp-content/plugins. Eg: you have a plugin in /wp-content/plugins/wp-spamfilter/wp-spamfilter.php then you have to call add_action as following:

```php
add_action('activate_wp-spamfilter/wp-spamfilter.php', 'somefunction');
```
