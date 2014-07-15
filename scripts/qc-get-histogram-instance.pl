#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Long;

use LWP::UserAgent;
use JSON;

use Bio::KBase::IDServer::Client;

sub usage {
  print "qc-get-histogram-instance.pl >>> retrieve a nucleotide histogram for a metagenome from the communities API\n";
  print "qc-get-histogram-instance.pl -id <id of the metagenome>\n"; 
}

sub help {
  my $text = qq~NAME

qc-get-histogram-instance -- retrieve a nucleotide histogram for a metagenome from the communities API

VERSION

1

SYNOPSIS

qc-get-histogram-instance [-h] -id metagenome_id

DESCRIPTION

Retrieve a nucleotide histogram for a metagenome from the communities API

PARAMETERS

-id metagenome_id

ID of the metagenome to retrieve the nucleotide histogram for

OPTIONS

-help

display this help message

-pass KB_password

KBase password to authenticate against the API, requires a username to be set as well

-user KB_user

KBase username to authenticate against the API, requires a password to be set as well

-token KB_token

KBase authentication token to authenticate against the API

OUTPUT

A nucleotide histogram

EXAMPLES

qc-get-histogram-instance -id "kb|mg.1"

SEE ALSO

-

AUTHORS

Jared Bischof, Travis Harrison, Folker Meyer, Tobias Paczian, Andreas Wilke
~;
  print $text;
}

my $HOST      = 'http://kbase.us/services/communities_qc/histogram/';
my $id        = '';
my $user      = '';
my $pass      = '';
my $token     = '';
my $help      = '';
my $webkey    = '';

GetOptions ( 'id=s' => \$id,
             'user=s' => \$user,
             'pass=s' => \$pass,
             'token=s' => \$token,
             'help' => \$help,
             'webkey=s' => \$webkey );

if ($help) {
  &help();
  exit 0;
}
unless ($id) {
  &usage();
  exit 0;
}

if ($id =~/^kb\|/) {
  my $id_server_url = "http://www.kbase.us/services/idserver";
  my $idserver = Bio::KBase::IDServer::Client->new($id_server_url);
  my $return = $idserver->kbase_ids_to_external_ids( [ $id ]);
  $id = $return->{$id}->[1] ;
}

if ($user || $pass) {
  if ($user && $pass) {
    my $exec = 'curl -s -u '.$user.':'.$pass.' -X POST "https://nexus.api.globusonline.org/goauth/token?grant_type=client_credentials"';
    my $result = `$exec`;
    my $ustruct = "";
    eval {
      my $json = new JSON;
      $ustruct = $json->decode($result);
    };
    if ($@) {
      die "could not reach auth server";
    } else {
      if ($ustruct->{access_token}) {
        $token = $ustruct->{access_token};
      } else {
        die "authentication failed";
      }
    }
  } else {
    die "you must supply both username and password";
  }
}

my $url = $HOST.$id;
if ($webkey) {
  $url .= "?webkey=".$webkey;
}
my $ua = LWP::UserAgent->new;
if ($token) {
  $ua->default_header('user_auth' => $token);
}
print $ua->get($url)->content;
