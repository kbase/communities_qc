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
	    "type"    => 'histogram',
	    "version" => 1,
	    "created" => strftime("%Y-%m-%dT%H:%M:%S", localtime) };

my $col_set = ['A', 'T', 'C', 'G', 'N'];
my $nucleo = [];
if (open(FH, "<$infile")) {
  while (<FH>) {
    chomp;
    my @row = split /\t/;
    push(@$nucleo, \@row);
  }
  close FH;
} else {
  print STDERR "ERROR: could not open result file\n";
  exit 1;
}

if ($nucleo && (@$nucleo > 2)) {
  # rows = [ pos, A, C, G, T, N, total ]
  my $rrow = [];
  my $prow = [];
  my $raw  = [];
  my $per  = [];
  
  foreach my $row (@$nucleo) {
    next if (($row->[0] eq '#') || (! $row->[6]));
    @$row = map { int($_) } @$row;
    push @$rrow, $row->[0] + 1;
    push @$raw, [ $row->[1], $row->[4], $row->[2], $row->[3], $row->[5], $row->[6] ];
    unless (($row->[0] > 100) && ($row->[6] < 1000)) {
      push @$prow, $row->[0] + 1;
      my $sum = $row->[6];
      my @per = map { floor(100 * 100 * (($_ * 1.0) / $sum)) / 100 } @$row;
      push @$per, [ $per[1], $per[4], $per[2], $per[3], $per[5] ];
    }
  }
  $obj->{counts}   = { rows => $rrow, columns => [@$col_set, 'Total'], data => $raw };
  $obj->{percents} = { rows => $prow, columns => $col_set, data => $per };
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
  print FH $json->encode({ "type" => "histogram",
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
