use strict;
use warnings;

use Getopt::Long;

use LWP::UserAgent;
use JSON;

use Bio::KBase::IDServer::Client;
use POSIX qw(strftime floor);

my $json = new JSON();

my $id     = "";
my $infile = "";

GetOptions ( 'file=s' => \$infile,
	     'id=s' => \$id );

my $obj = { "id"      => $id,
	    "type"    => 'kmer',
	    "version" => 1,
	    "created" => strftime("%Y-%m-%dT%H:%M:%S", localtime),
	    "columns" => [ 'count of identical kmers of size N',
			   'number of times count occures',
			   'product of column 1 and 2',
			   'reverse sum of column 2',
			   'reverse sum of column 3',
			   'ratio of column 5 to total sum column 3 (not reverse)' ] };
      
my $kmer = [];
if (open(FH, "<$infile")) {
  while (<FH>) {
    chomp;
    my @row = split /\t/;
    push(@$kmer, \@row);
  }
  close FH;
} else {
  print STDERR "ERROR: could not open result file\n";
  exit 1;
}
 
if ($kmer && (@$kmer > 1)) {
  foreach my $row (@$kmer) {
    @$row = map { $_ * 1.0 } @$row;
  }
  $obj->{profile} = $kmer;
}
  
# write the result to a json file
if(open(FH, ">seqs.stats.json")) {
  print FH $json->encode($obj);
  close FH;
} else {
  print STDERR "ERROR: could not create result file\n";
  exit 1;
}

# write attributes to the attribute file
if(open(FH, ">attributes")) {
  print FH $json->encode({ "type" => "kmer",
			   "id" => $id });
  close FH;
} else {
  print STDERR "ERROR: could not create attributes file\n";
  exit 1;
}

print STDOUT "success\n";

exit 0;

# enable hash-resolving in the JSON->encode function
sub TO_JSON { return { %{ shift() } }; }
