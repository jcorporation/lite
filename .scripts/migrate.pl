#!/usr/bin/perl -w
use strict;

sub replace_src() {
    my $src = $_[0];
    if ($src =~ /^lite\/design\/(.+)$/) {
        return "src=\"\{\{ site.baseurl \}\}/assets/pics/$1\"";
    }
    return "src=\"\{\{ site.baseurl \}\}/assets/pics/$src\"";
}

sub replace_href() {
    my $href = $_[0];
    my $text = $_[1];
    if ($href =~ /^(http|mailto)/) {
        return "[$text]($href)"
    }
    if ($href eq "//jcgames/lizenz") {
        return "[$text]({{ site.baseurl }}/lizenz)"
    }
    return "[$text]({{ site.baseurl }}$href)"
}

sub replace_h() {
    my $text = $_[0];
    my $level = $_[1];
    my $ret = "";
    for (my $i = 0; $i < $level; $i++) {
        $ret .= "#";
    }
    return $ret." ".$text."\n";
}

my $title = "";
open my $in, $ARGV[0] or die;
while (<$in>) {
    if (/<h1[^>]+>(.*)<\/h1>/) {
        $title = $1;
        $title =~ s/<[^>]+>//g;
        last;
    }
}
close $in;

open $in, $ARGV[0] or die;
open my $out, ">".$ARGV[0].".md" or die;
print $out qq|---
layout: page
permalink: /$ARGV[0]
title: $title
---

|;

while (<$in>) {
    chomp;
    s|src=\"/www/([^"]+)\"|&replace_src($1)|ge;
    s|<a href=\"([^"]+)\">([^<]+)</a>|&replace_href($1, $2)|ge;
    s|\&auml;|ä|g;
    s|\&ouml;|ö|g;
    s|\&uuml;|ü|g;
    s|\&Auml;|Ä|g;
    s|\&Ouml;|Ö|g;
    s|\&Uuml;|Ü|g;
    s|\&szlig;|ß|g;
    s|\&nbsp;| |g;
    s|  | |g;
    s|<h(\d)>([^<]+)</h\d>|&replace_h($2, $1)|ge;
    s|<li>(.*)</li>$|- $1|g;
    s|<p>(.*)</p>|$1\n|g;
    s|^</ul>$||;
    s|^\s+$||;
    s|<hr/>|***|g;
    if (m/^<ul>/) {
        print "i";
        next;
    }
    print $out $_."\n";
}
close $in;
close $out;