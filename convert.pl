#! /usr/bin/env perl

use strict;
use warnings;

my $dir = shift @ARGV;
die "usage: $0 directory\n" unless $dir;
chdir $dir;

opendir(DIR, ".");
while (my $file = readdir(DIR)) {
    next if $file =~ m/^\.\.?$/;
    if ($file =~ m/Start to run \d+-\d+ les (\d\d.mp3)/) {
	rename $file, $1;
    }
}
closedir(DIR);
