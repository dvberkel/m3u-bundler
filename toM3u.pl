#! /usr/bin/env perl

use strict;
use warnings;


use Getopt::Long;

my $bundleSize = 2;
my $outputDir = ".";
my $prefix = "";
my $dir;
my $help;

GetOptions(
    "dir=s" => \$dir, 
    "size=s" => \$bundleSize, 
    "help" => \$help,
    "output=s" => \$outputDir,
    "prefix=s" => \$prefix
);

if ($help || not $dir) {
    die <<EOU
usage: $0 --dir directory [--size number] [--output directory] [--prefix string] [-h]
where:
  --dir directory     is the directory which will be bundled into playlists.
  --size number       is the number of files per playlist.
  --output directory  is the directory in which the playlists are stored.
  --prefix string     is the prefix of the files.
  --help              shows this help file.  
EOU
}

my @files = ();
opendir(DIR, $dir);
while (my $file = readdir(DIR)) {
    next if $file =~ m/^\.\.?$/;
    push @files, $file;
}
closedir(DIR);

@files = sort @files;

my $count = 0;
while (scalar(@files) > 0) {
    $count++;
    open(FILE, ">$outputDir/$count.m3u");
    for (my $index = 0; $index < $bundleSize; $index++) {
	my $file = shift @files;
	if ($file) {
	    print FILE "$prefix$dir$file\n";
	}
    }
    close(FILE);
}

