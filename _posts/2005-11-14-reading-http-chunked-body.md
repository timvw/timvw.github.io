---
ID: 64
post_title: Reading http chunked body
author: timvw
post_date: 2005-11-14 21:40:53
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/11/14/reading-http-chunked-body/
published: true
---
<p>Here is my implementation of <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.6.1">Chunked Transfer Coding</a>. I find it quite elegant compared to other snippets i've seen.</p>

[code lang="perl"]
###################################################
# {{{ read body chunked
###################################################
sub getbodychunked
{
	my $sh = shift; # the socket handle should be passed
	my ($in, $body);

	for ($in = < $sh>; defined $in; $in = < $sh>)
	{
		$in = trim $in;
		my $chunk = hex $in;
		while (defined $in && $chunk > 0)
		{
			$chunk -= read $sh, $in, $chunk;
			$body .= $in;
		}
	}
	return $body;
}
[/code]