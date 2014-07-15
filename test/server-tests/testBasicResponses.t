#!/usr/bin/perl
#  
#  The purpose of this test is to make sure we recieve some response from the server for the list of functions
#  given.  Each of these functions listed should return some value, but the actual value is not checked here.
#  Thus, this test is ideal for making sure you are actually recieving something from a service call even if
#  that service is not yet implemented yet.
#
#  If you add functionality to the API, you should add an appropriate test here.
#
#  author:  msneddon
#  created: 5/21/2012
#  updated: 12/03/2012 landml

use strict;
use warnings;

use Data::Dumper;
use Test::More tests=>9;
use lib "client";
use lib "test/server-tests";
use QCTestConfig qw(getHost getPort);

#############################################################################
# HERE IS A LIST OF METHODS AND PARAMETERS THAT WE WANT TO TEST
# NOTE THAT THE PARAMETERS ARE JUST MADE UP AT THE MOMENT

my $my_drisee_id = 'a867241a-6df1-4b39-8dc0-0f0b4ef940e6';
#my $my_drisee_id = 'kb|mg.1';
my @my_drisee_id = ('kb|mg.1');
my @func_calls = qw (get_drisee_compute get_drisee_instance get_histogram_compute get_histogram_instance get_kmer_compute);
my $func_calls = {
                get_drisee_compute =>  { id => $my_drisee_id }, 
                get_drisee_instance => { id => $my_drisee_id }, 
                get_histogram_compute =>  { id => $my_drisee_id }, 
                get_histogram_instance => { id => $my_drisee_id }, 
                get_kmer_compute =>  { id => $my_drisee_id }, 
                get_kmer_instance => { id => $my_drisee_id }, 
                 };
#############################################################################
my $n_tests = (scalar(@func_calls)+4); # set this to be the number of function calls + 3

# MAKE SURE WE LOCALLY HAVE JSON RPC LIBS
use_ok("JSON::RPC::Client");
use_ok("Microbial_Communities_QCClient");

# MAKE A CONNECTION (DETERMINE THE URL TO USE BASED ON THE CONFIG MODULE)
my $host=getHost(); my $port=getPort();
print "-> attempting to connect to:'".$host.":".$port."'\n";
my $client = Microbial_Communities_QCClient->new($host.":".$port);

ok( defined $client, "Did an object get defined" );               

#  Can the object do all of the methods
can_ok($client, @func_calls);

# LOOP THROUGH ALL THE FUNCTION CALLS AND MAKE SURE WE GOT SOMETHING
my $method_name;
for $method_name (@func_calls) {
        my $result;
        print "calling function: \"$method_name\"\n";
	print "curl -X POST -d '{ \"params\": { \"id\": \"$my_drisee_id\" }, \"method\": \"$method_name\" }' '$host:$port' \n";
        {
            no strict "refs";
            $result = $client->$method_name( { id => $my_drisee_id } );
        }
        ok($result,"looking for a response from \"$method_name\"");
}

done_testing($n_tests);
