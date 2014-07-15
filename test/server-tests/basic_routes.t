#!/usr/bin/env perl
# Test the basic routes for this service
# - This assumes that the service is deployed to localhost on port 7052
# - And that the root resource contains a list of additional resources

use strict;
use warnings;
use Test::More tests => 13;
use Data::Dumper;
use LWP::Simple;
use lib "lib";
use lib "test/server-tests";
use QCTestConfig qw(getHost getPort);

use JSON;
my $j = JSON->new->utf8;

my $testCount = 0;

# MAKE A CONNECTION (DETERMINE THE URL TO USE BASED ON THE CONFIG MODULE)
my $host=getHost(); my $port=getPort();
print "-> attempting to connect to:'".$host.":".$port."'\n";
#my $data = get("http://localhost:7052");
my $data = get("$host:$port");

ok (defined $data,"Connection to HOST:PORT returned defined data");

my $obj  = '';
eval { $obj  = $j->decode($data); };
ok (! $@, "The return can decode to JSON $@");

if ($@) { note("RETURN:  $data\nERROR: $@"); }

is (ref($obj),'HASH',"The JSON decodes to a HASH");
ok (defined $obj->{resources}, "JSON formatted key resources returned");
$testCount += 4;

foreach my $resource (@{$obj->{resources}}) {

	my $url = $resource->{url};
	my $json='';
	my $d2 = get($url);
	ok ( defined $d2,"The URL $url returned defined data");
print "DEBUG: D2=$d2\n";
	eval { $json = $j->decode($d2); };
	ok (! $@, "The return can decode to JSON ");

	if ($@) { note("RETURN:  $d2\nERROR: $@"); }

	is (ref($json),'HASH',"The JSON decodes to a HASH");
	
	$testCount += 1;
}

done_testing();
