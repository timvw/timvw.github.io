---
ID: 117
post_title: >
  Adding support for localization to a
  WordPress plugin
author: timvw
post_date: 2006-03-19 02:34:29
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/03/19/adding-support-for-localization-to-a-wordpress-plugin/
published: true
---
<p>WordPress uses <a href="http://www.gnu.org/software/gettext/">GNU gettext</a>, as explained in <a href="http://codex.wordpress.org/Localizing_WordPress">Translating WordPress</a> and <a href="http://codex.wordpress.org/Writing_a_Plugin">Writing a Plugin</a>, for <a href="http://en.wikipedia.org/wiki/Software_localization">localization</a>. I decided that my plugins should support l10n too. Here is how i realised it:</p>

<p>I started with defining the WPLANG constant in my wp-config.php:</p>
[code lang="php"]define ('WPLANG', 'en_EN');[/code]

<p>Then i changed the beginning of my localized plugin as following:</p>
[code lang="php"]<?php
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
[/code]

<p>In wp-includes/wp-l10n.php you see that the result of this call is that the locale and the path are used to determine the mo-file to be loaded. Because this function uses ABSPATH it's impossible to use dirname(__FILE__) as path parameter :(</p>

<p>The _e($string, $domain) function echos a localized string and the __($string, $domain) function returns a localized string that you can use in function calls etc... Below you can see an example of the original version and the updated version with localization support: </p>
[code lang="php"]
<h2>some string</h2>
<?php echo('some other string'); ?>
[/code]

[code lang="php"]
<h2><?php _e('some string', 'wp_spamfilter'); ?></h2>
<?php echo(__('some other string', 'wp_spamfilter')); ?>
[/code]

<p>Then i used xgettext to extract all the strings that should be localized into wp_spamfilter-en_EN.po:</p>
[code lang="dos"]
xgettext --keyword=__ --keyword=_e --default-domain=wordpress --language=php *.php --output=wp_spamfilter-en_EN.po
[/code]

<p>After that i editted the po file and i compiled a mo file with it using msgfmt:</p>
[code lang="dos"]
msgfmt wp_spamfilter-en_EN.po -o wp_spamfilter-en_EN.mo
[/code]

<p>Once i had made sure that wp_spamfilter-en_EN.mo was readable by my webserver i was ready.</p>