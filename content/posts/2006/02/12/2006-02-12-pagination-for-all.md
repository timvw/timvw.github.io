---
date: "2006-02-12T00:00:00Z"
tags:
- PHP
title: Pagination for all
---
Suppose you have a a large collection of items and you want to display them. Users don't want to see 5000 items at once. They only want to see a couple of items and have the possibility to look at the next (or previous) couple of items. The solution for this problem is usually named pagination. You can compare this technique with [paging](http://en.wikipedia.org/paging). Most people seem to come up with their own (My)SQL specific implementation. Here are a couple of examples how you can use [mine](http://www.timvw.be/wp-content/code/php/pagination.txt)

```php
<?php
require('http://www.timvw.be/wp-content/code/php/pagination.txt');

// step 1 - create pageable data: array example
$data = array(
	array('name' => 'Jameson', 'surname' => 'Jenna'),


array('name' => 'Banks', 'surname' => 'Briana'),
array('name' => 'Giovanni', 'surname' => 'Aria'),
array('name' => 'Rush', 'surname' => 'Daniella'),
array('name' => 'Flowers', 'surname' => 'April')
);
$pageabledata = new PageableArray($data);

// step 2 -- create the pager
$pager = new Pager($pageabledata);

// step 3 -- create the pagewriter
$pagewriter = new PageWriter($pager);

// step 4 -- create the paginator
$paginator = new Paginator($pagewriter);

// step 5 -- run the paginators
$paginator->run();

// setp 6 -- output
$paginator->output();
?>
```

I have also provided code for situations where you want to paginate File contents, MySQL or ADODB resultsets. In that case the code for step 1 would look like

```php
<?php
// file example
$pageabledata = new PageableFile("/home/users/timvw/.bash_history");

// mysql example
$dblink = mysql_connect('localhost', 'username', 'password');
mysql_select_db('dbname', $dblink);
$pageabledata = new PageableMySQL('SELECT * FROM wp_posts ORDER BY 1', $dblink);

// adodb example
require('adodb/adodb.inc.php');
$db = NewADOConnection('mysql://username:password@localhost/dbname');
$pageabledata = new PageableADODB('SELECT * FROM wp_posts ORDER BY 1', $db);
?>
```

You will probably want to modify the code so that it generates the html you want. Here is how an example of such a change

```php
<?php
/**
 * This class represents a PageJumpWriter
 */
class PageJumpWriter extends PageWriter {
        /**
         * Default constructor
         * @param $pager the pager
         * @param $base_url the baseurl for the pager
         * @param $page_param the name of the page parameter
	 * @param $items_per_page_param the name of the items per page parameter
	 * @param $params additional url parameters in the form of a name=>value array


*/
function PageJumpWriter(&$pager, $base\_url = ", $page\_param = 'page', $items\_per\_page\_param = 'items\_per_page', $params = null) {
parent::PageWriter($pager, $base\_url, $page\_param, $items\_per\_page_param, $params);
}

/**
* Generate html for the items pager
* @see PageWriter#makeItemsPager
*/
function makeItemsPager() {
$current_page = $this->pager->getCurrentPage();
$last_page = $this->pager->getLastPage();
$prev\_page = $current\_page -- 1;
$next\_page = $current\_page + 1;
$items\_per\_page = $this->pager->getItemsPerPage();
$html = " 

<div class='itemspager'>
  ";<br /> $html .= "<br /> 
  <p>
    ";<br /> $html .= "
  </p>
</div>

";
return $html;
}
}
?>
```

If you want to use this customized html generator you simple change the code in step 3 as following

```php
<?php
$pagewriter2 = new PageJumpWriter($pager2);
?>
```

The problem with most of these paginators is that you can only use one per page. This is a serious [PITA](http://en.wiktionary.org/wiki/PITA). It's your lucky day, here is an example of two paginators that can run separately in the same page

```php
<?php
// step 1 - create the pageable data
$dblink = mysql_connect('localhost', 'username', 'password');
mysql_select_db('dbname', $dblink);
$pageabledata = new PageableMySQL('SELECT * FROM wp_posts ORDER BY 1', $dblink);
$pageabledata2 = new PageableFile('/var/www/somefile.txt');

// step 2 - create the pagers
$pager = new Pager($pageabledata);
$pager2 = new Pager($pageabledata2);

// step 3 - create the pagewriters
$pagewriter = new PageWriter($pager);
$pagewriter2 = new PageJumpWriter($pager2, '', 'page2', 'items_per_page2');

// step 4 - create the paginators
$paginator = new Paginator($pagewriter);
$paginator2 = new Paginator($pagewriter2);

// step 5 - run the paginators
$paginator->run();


$paginator2->run();

// add extra url parameters for pagewriters
$pagewriter->setParameters(array(
$pagewriter2->getPageParam() => $pagewriter2->pager->getCurrentPage(),
$pagewriter2->getItemsPerPageParam() => $pagewriter2->pager->getItemsPerPage()
));

$pagewriter2->setParameters(array(
$pagewriter->getPageParam() => $pagewriter->pager->getCurrentPage(),
$pagewriter->getItemsPerPageParam() => $pagewriter->pager->getItemsPerPage()
));

// step 6 -- output
$paginator->output();
$paginator2->output();
?>
```
