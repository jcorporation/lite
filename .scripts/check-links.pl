#!/usr/bin/perl -w
use strict;

my $checkfile = $ARGV[0];

sub checklink {
    my ($href, $line) = @_;

    if ($href =~ /^(http|mailto)/) {
        return;
    }
    if ($href =~ /^\{\{ site\.baseurl \}\}\/(.*)$/) {
        my $file = $1;
        if ($file =~ /\/$/) {
            $file .= "index";
        }
        if (not $file =~ /\.(pdf|png|jpg|svg)$/) {
            $file .= ".md";
        }
        if (not -f $file) {
            print "$checkfile:$line - Invalid link: \"$file\" (file not found)\n";
        }
    }
    else {
        print "$checkfile:$line - Invalid link: \"$href\" (missing {{ site.baseurl }}/)\n";
    }
}

open my $fh, $checkfile or die;
my $line = 0;
while (<$fh>) {
    $line++;
    while (/<a href="([^"]+)"/g) {
        checklink($1, $line);
    }
    while (/\[[^\]]+\]\(([^)]+)\)/g) {
        checklink($1, $line);
    }
    while (/src="([^"]+)"/g) {
        checklink($1, $line);
    }
}
close $fh;
