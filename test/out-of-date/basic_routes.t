#!/usr/bin/env perl
# Test the basic routes for this service
# - This assumes that the service is deployed to localhost on port 7052
# - And that the root resource contains a list of additional resources

use strict;
use warnings;
use Test::More tests => 6;
use Data::Dumper;
use LWP::Simple;
use JSON;
my $testCount = 0;

my $j = JSON->new->utf8;
my $data = get("http://localhost:7052");
ok defined $data;
my $obj  = $j->decode($data);
ok defined $obj->{resources};
$testCount += 2;

foreach my $resource (@{$obj->{resources}}) {
	my $url = $resource->{url};
	my $d2 = get($url);
	ok defined $data;
	$testCount += 1;
}

done_testing($testCount);
