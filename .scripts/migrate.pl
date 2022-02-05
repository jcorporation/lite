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
        return "[$text]({{ site.baseurl }}/Kontakt)"
    }
    my @hrefs = split /\//, $href;
    $href = "";
    for (@hrefs) {
        $href.= "/".ucfirst($_);
    }
    $href=~s|//|/|g;
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
    if (/<h1[^>]*>(.*)<\/h1>/) {
        $title = $1;
        $title =~ s/<[^>]+>//g;
        $title =~ s|\&auml;|ä|g;
        $title =~ s|\&ouml;|ö|g;
        $title =~ s|\&uuml;|ü|g;
        $title =~ s|\&Auml;|Ä|g;
        $title =~ s|\&Ouml;|Ö|g;
        $title =~ s|\&Uuml;|Ü|g;
        $title =~ s|\&szlig;|ß|g;
        last;
    }
}
close $in;

open $in, $ARGV[0] or die;
my $outfile = "";
my ($path, $file) = $ARGV[0] =~ /(.*)\/([^\/]+)$/;
if ($file ne "index") {
    $outfile = $path."/".ucfirst($file).".md";
}
else {
    $outfile = $path."/".$file.".md";
}

my @permalinks = split /\//, $ARGV[0];
my $permalink = "";
for (@permalinks) {
    $permalink.= "/".ucfirst($_);
}
$permalink =~ s|//|/|g;
$permalink =~ s|/./|/|g;
$permalink =~ s|/index$|/|g;

open my $out, ">".$outfile or die;
#print $out qq|---
#layout: page
#permalink: $permalink
#title: $title
#---
#
#|;

while (<$in>) {
    chomp;
    s|src=\"/www/([^"]+)\"|&replace_src($1)|ge;
    s|\[([^\[]+)\[([^\]]+)\]|&replace_href($1, $2)|ge;
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
    s|<strong>([^<]+)</strong>|**$1**|g;
    s|<em>([^<]+)</em>|*$1*|g;
    s|<hr/>|***|g;
    s|<article>||g;
    s|<section>||g;
    s|</article>||g;
    s|</section>||g;
    s|<aside>||g;
    s|</aside>||g;
    if (m/^<ul>/) {
        next;
    }
    print $out $_."\n";
}
close $in;
close $out;
