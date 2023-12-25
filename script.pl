#!/usr/bin/perl
use strict;
use warnings;

use YAML::XS 'LoadFile';
use JSON;
use Cwd qw(getcwd);
use Data::Dumper;
use File::Basename;

my $dir = $ARGV[0];
my $delete = $ARGV[1];

chdir $dir;

my @files = glob "*.yaml";

for (0..$#files) {
    my $file = $files[$_];
    print "Processing file $file";

    my $yaml_file = LoadFile("$file");
    my $json = encode_json($yaml_file);

    open my $fh, '>', basename($file, ".yaml").".json";

    print {$fh} $json;

    close $fh;

    if ($delete eq "true") {
        unlink($file) or die "Can't delete $file!\n";
    }
}
