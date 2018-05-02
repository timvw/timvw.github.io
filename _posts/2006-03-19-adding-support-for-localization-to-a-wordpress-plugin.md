---
id: 117
title: Adding support for localization to a WordPress plugin
date: 2006-03-19T02:34:29+00:00
author: timvw
layout: post
guid: http://www.timvw.be/adding-support-for-localization-to-a-wordpress-plugin/
permalink: /2006/03/19/adding-support-for-localization-to-a-wordpress-plugin/
tags:
  - WordPress
---
WordPress uses [GNU gettext](http://www.gnu.org/software/gettext/), as explained in [Translating WordPress](http://codex.wordpress.org/Localizing_WordPress) and [Writing a Plugin](http://codex.wordpress.org/Writing_a_Plugin), for [localization](http://en.wikipedia.org/wiki/Software_localization). I decided that my plugins should support l10n too. Here is how i realised it:

I started with defining the WPLANG constant in my wp-config.php:

```php
define ('WPLANG', 'en_EN');
```

Then i changed the beginning of my localized plugin as following:

```php
<?php
/*
Plugin Name: WP-SpamFilter
Version: 0.4
Plugin URI: http://timvw.madoka.be/?p=533
Description: Mark the new comment as spam if the sender is in the spammers list.
Author: Tim Van Wassenhove <timvw@users.sourceforge.net>


Author URI: http://timvw.be
*/

// If this function does not exist it means that the file is accessed directly.
// Accessing this file directly is not allowed.
if (!function_exists('load_plugin_textdomain')) {
exit;
}

load_plugin_textdomain('wp_spamfilter', 'wp-content/plugins/wp-spamfilter');
```

In wp-includes/wp-l10n.php you see that the result of this call is that the locale and the path are used to determine the mo-file to be loaded. Because this function uses ABSPATH it's impossible to use dirname(__FILE__) as path parameter

The _e($string, $domain) function echos a localized string and the __($string, $domain) function returns a localized string that you can use in function calls etc... Below you can see an example of the original version and the updated version with localization support: 

```php

## some string

<?php echo('some other string'); ?>


```

```php

## <?php _e('some string', 'wp_spamfilter'); ?>

<?php echo(__('some other string', 'wp_spamfilter')); ?>


```

Then i used xgettext to extract all the strings that should be localized into wp_spamfilter-en_eN.po:

```dos
xgettext --keyword=__ --keyword=_e --default-domain=wordpress --language=php *.php --output=wp_spamfilter-en_EN.po
```

After that i editted the po file and i compiled a mo file with it using msgfmt:

```dos
msgfmt wp_spamfilter-en_eN.po -o wp_spamfilter-en_eN.mo
```

Once i had made sure that wp_spamfilter-en_eN.mo was readable by my webserver i was ready.
