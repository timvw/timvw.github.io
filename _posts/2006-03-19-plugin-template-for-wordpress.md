---
title: Plugin template for WordPress
layout: post
tags:
  - WordPress
---
Today i've been cleaning up my code. All my plugins live in a directory %plugin_name% under the wp-content/plugins directory. Here is the code for %plugin_name%/%plugin_name%.php

```php
<?php
/*
Plugin Name: %plugin_name%
Version: %plugin_version%
Plugin URI: %plugin_uri%
Description: %plugin_description%


Author URI: %plugin_author_uri%
*/

// Direct access is not allowed.
if (!function\_exists('load_plugin_textdomain')) {
exit;
} else {
require('%plugin_name%.php');
$plugin_name = substr(basename(__FILE__), 0, -4);

// You can add optional parameters to the constructor, eg: the wpdb instance.
$%plugin_class% = new %plugin_class%($plugin_name);
}
?>
```

Now it's time to implement the %plugin_class%. Here is the template for %plugin_name%/%plugin_class%.php:

```php
<?php

class %plugin_class% {
  var $_plugin_name;

  var $_localization_domain;
  var $_localization_path;

  function %plugin_class%($plugin_name = '%plugin_name%') {
    $this->_plugin_name = $plugin_name;

$this->_localization_domain = $plugin_name;
$this->_localization_path = 'wp-content/plugins/' . $plugin_name;

// You can add additional hooks and filters here.
add_action('activate_' . $plugin_name . '/' . $plugin_name . '.php', array(&$this, 'OnActivation'));
add_action('admin_menu', array(&$this, 'OnAdminMenu'));
}

function OnAdminMenu() {
load_plugin_textdomain($this->_localization_domain, $this->_localization_path);
add_options_page(__('%plugin_name% Options', $this->_localization_domain), __('%plugin_name%', $this->_localization_domain), 'manage_options',$this->_plugin_name . '/' . $this->_plugin_name . '-options.php', array(&$this, 'OnDisplayOptions'));
}

function OnDisplayOptions() {
$%plugin_class% = "";
require( dirname(__FILE__) . '/' . $this->_plugin_name . '-options.php');
}

function OnActivation() {
// This code is executed when the plugin is activated.
// I prepend all my option names with $this->_plugin_name.
add_option($this->_plugin_name . '_somevar', 'foo');
}
}
?>
```

The code above requires that you create a %plugin_name%/%plugin_name%-options.php file to administrate the options. Here is the template for that file:

```php
<?php
// Direct access is not allowed.
if (!isset($%plugin_class%)) {
  exit;
}

load_plugin_textdomain($%plugin_class%->_localization_domain, $%plugin_class%->_localization_path);

// Handle post action.
if ($_POST['stage'] == 'process') {
// All the names of form variables start with %plugin_class%_plugin_name.
if (isset($_POST[$%plugin_class%->_plugin_name . '_somevar'])) {
// Do processing here.
}
}

?>

```

The only thing that we still have to do is generate a po file with xgettext, translate it and compile a %plugin_name%/%plugin_name%-en_EN.mo file.
