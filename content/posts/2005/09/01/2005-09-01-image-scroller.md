---
date: "2005-09-01T00:00:00Z"
tags:
- JavaScript
title: Image scroller
aliases:
 - /2005/09/01/image-scroller/
 - /2005/09/01/image-scroller.html
---
```javascript
// +—————————————————————————
// | // |
// | A javascript picture scroller
// +—————————————————————————

var i = 0;
var pics = new Array();

// define the pictures you want to show (html id, image url, link url)
pics[i++] = new picture(‘pic’ + i, ‘/images/scroller/top03.jpg’, ‘http://www.microsoft.com’);
//pics[i++] = new picture(‘pic’ + i, ‘/images/scroller/top04.jpg’, ‘http://www.khleuven.be’);
pics[i++] = new picture(‘pic’ + i, ‘/images/scroller/top05.jpg’, ‘/rss.php’);
pics[i++] = new picture(‘pic’ + i, ‘/images/scroller/top11.jpg’, ”);

// define the sleep interval
var slow = 100;

/**
* global variables
*/
var lastindex = pics.length;
var pause;
var pictures;
var offset;
var left;

/**
* Scroll
*
* @param id the id in which the scroller should be drawn
*/
function scroller(id)
{
	// load pictures
	pictures = new Array(lastindex);
	for (i = 0; i < lastindex; ++i)
	{
		pictures[i] = new Image();
		pictures[i].src = pics[i].pictureurl;
	}

	offset = document.getElementById(id).offsetLeft + 161;

	// attach pictures to html, display:none
	for (i = 0; i < lastindex; ++i)
	{
		purl = pics[i].pictureurl;
		lurl = pics[i].linkurl;
		pid = pics[i].id;
		ileft = 0;
		document.getElementById(id).innerHTML += ‘<a href="’ + lurl + ‘"><img src="’ + purl + ‘" id="’ + pid + ‘" style="display: none; position: absolute; left:’ + ileft + ‘px; top: 27px;"/></a>’;
	}

	// start
	pause = setInterval("start()", 500);
}

/**
* A container for a picture
*
* @param id the DOM id for this picture
* @param imageurl the URL where the picture can be found
* @param linkurl the URL where the user should be directed to if he clicks the picture
*/
function picture(id, pictureurl, linkurl)
{
	this.id = id;
	this.pictureurl = pictureurl;
	this.linkurl = linkurl;
}

/**
* Determine of the pictures are ready to be displayed
*/
function ready()
{
	// test if there is a picture that is not completely loaded
	for (i = 0; i < lastindex; ++i)
	{
		id = pics[i].id;
		if (!document.getElementById(id).complete)
		{
			return false;
		}
	}
	return true;
}

/**
* Do the actual scrolling
*/
function work()
{
	// move all the pictures to the left
	for (i = 0; i < lastindex; ++i)
	{
		left[i] -= 1;

		// if picture is out the container, position it at the right of the other pictures
		if (left[i] <= offset)
		{

			n = i – 1;
			if (n < 0)
			{
				n = lastindex – 1;
			}

			l = left[n];
			l += pictures[n].width + 10;
			left[i] = l;
		}

		id = pics[i].id;
		ileft = left[i];
		document.getElementById(id).style.left = ileft + ‘px’;
	}
}

/**
* Start the scroller
*/
function start()
{
	if (ready())
	{
		window.clearInterval(pause);

		// calculate positions and make visible
		left = new Array(lastindex);

		for (i = 0; i < lastindex; ++i)
		{
			l = offset;
			for (n = 0; n < i; ++n)
			{
				l += pictures[n].width + 10;
			}
			left[i] = l;

			id = pics[i].id;
			ileft = left[i];
			document.getElementById(id).style.display = ‘inline’;
			document.getElementById(id).style.left = ileft + ‘px’;
		}

		// work
		interval = setInterval(‘work();’, slow);
	}
}
```
