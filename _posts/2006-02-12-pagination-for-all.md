---
ID: 40
post_title: Pagination for all
author: timvw
post_date: 2006-02-12 02:54:14
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/02/12/pagination-for-all/
published: true
dsq_thread_id:
  - "1920134368"
---
<p>Suppose you have a a large collection of items and you want to display them. Users don't want to see 5000 items at once. They only want to see a couple of items and have the possibility to look at the next (or previous) couple of items. The solution for this problem is usually named pagination. You can compare this technique with <a href="http://en.wikipedia.org/paging">paging</a>. Most people seem to come up with their own (My)SQL specific implementation. Here are a couple of examples how you can use <a href="http://www.timvw.be/wp-content/code/php/pagination.txt">mine</a>:</p>
[code lang="php"]<?php
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

// step 2 - create the pager
$pager = new Pager($pageabledata);

// step 3 - create the pagewriter
$pagewriter = new PageWriter($pager);

// step 4 - create the paginator
$paginator = new Paginator($pagewriter);

// step 5 - run the paginators
$paginator->run();

// setp 6 - output
$paginator->output();
?>[/code]

<p>I have also provided code for situations where you want to paginate File contents, MySQL or ADODB resultsets. In that case the code for step 1 would look like:</p>

[code lang="php"]<?php
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
?>[/code]

<p>You will probably want to modify the code so that it generates the html you want. Here is how an example of such a change:</p>

[code lang="php"]<?php
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
	function PageJumpWriter(&$pager, $base_url = '', $page_param = 'page', $items_per_page_param = 'items_per_page', $params = null) {
		parent::PageWriter($pager, $base_url, $page_param, $items_per_page_param, $params);
	}

	/**
	 * Generate html for the items pager
	 * @see PageWriter#makeItemsPager
	 */
	function makeItemsPager() {
                $current_page = $this->pager->getCurrentPage();
                $last_page = $this->pager->getLastPage();
                $prev_page = $current_page - 1;
                $next_page = $current_page + 1;
		$items_per_page = $this->pager->getItemsPerPage();
                $html = "<div class='itemspager'>";
		$html .= "<form method='GET' action='{$this->base_url}' onChange='this.submit()'>";
		$html .= "<select name='{$this->page_param}'>";
		for ($i = 1; $i <= $last_page; ++$i) {
			if ($i != $current_page) {
				$html .= "<option value='{$i}'>Page {$i} of {$last_page}</option>";
			} else {
				$html .= "<option value='{$i}' selected>Page {$i} of {$last_page}</option>";
			}
		}
		$html .= "</select>";
		$html .= "<input type='hidden' name='{$this->items_per_page_param}' value='{$items_per_page}'/>";
		foreach($this->params as $name => $value) {
			$html .= "<input type='hidden' name='{$name}' value='{$value}'/>";
		}
		$html .= "<input type='submit' value='Go'/>";
		$html .= "</form>";
                $html .= "</div>";
                return $html;
	}
}
?>[/code]

<p>If you want to use this customized html generator you simple change the code in step 3 as following:</p>

[code lang="php"]<?php
$pagewriter2 = new PageJumpWriter($pager2);
?>[/code]

<p>The problem with most of these paginators is that you can only use one per page. This is a serious <a href="http://en.wiktionary.org/wiki/PITA">PITA</a>. It's your lucky day, here is an example of two paginators that can run separately in the same page:</p>

[code lang="php"]<?php
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

// step 6 - output
$paginator->output();
$paginator2->output();
?>[/code]