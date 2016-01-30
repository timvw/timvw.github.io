---
ID: 66
post_title: Handling options
author: timvw
post_date: 2005-11-10 21:45:54
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/11/10/handling-options/
published: true
---
<p>Last couple of days i've been writing a little script in Perl. One of the requirements is the following: it accepts (eventual) parameters to indicate the port it should use, where it should write log messages, how verbose the logging is. To do implement this i use the <a href="http://perldoc.perl.org/Getopt/Std.html">Getopt::Std</a> module. You can see in the following snippet how easy it makes things: (Notice how it takes care of invalid option switches etc...)</p>

[code lang="perl"]
#!/usr/bin/env perl
###############################################
# Author: Tim Van Wassenhove
# Update: $Id:$
###############################################
# {{{ initialize
###############################################
use strict;
use diagnostics;
use Getopt::Std;

use constant {
        DEFAULT_PORT => 8888,
        DEFAULT_LOGFILE => "&STDOUT",
        DEFAULT_LOGLEVEL => 5,
        PROGNAME => "stupid proxy/0.1",
};
# }}}
###############################################
# {{{ display usage options
###############################################
sub usage
{
        print STDERR < < "EOF";
usage: $0 [-p port] [-f logfile] [-l level]

-h              : this (help) message
-p port         : the portnumber to run this proxy server on
-f logfile      : the file where the logging message go to
-l loglevel     : the level of verboseness of the logging, 0 is silent, 5 is loud

Report bugs and suggestions at http://timvw.madoka.be
EOF
        exit;
}
# }}}
###############################################
# {{{ main entry point
###############################################
my %options;
getopts 'p:f:l:h', \%options or usage;
usage if exists $options{h};

# use default port unless user gave different port
my $port = DEFAULT_PORT;
if (exists $options{p} && $options{p} =~ /^\d+$/)
{
        $port = $options{p};
}

# use default logfile unless user gave different file
my $logfile = DEFAULT_LOGFILE;
if (exists $options{f})
{
        $logfile = $options{f};
}

# use default loglevel, unless user gave different level
my $loglevel = DEFAULT_LOGLEVEL;
if (exists $options{l} && $options{l} >= 0 && $options{l} < = 5)
{
        $loglevel = $options{l};
}
[/code]