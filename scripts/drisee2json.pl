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
my $log    = "";

GetOptions ( 'file=s' => \$infile,
	     'log=s' => \$log,
	     'id=s' => \$id );

# create return hash
my $obj = { "id"      => $id,
	    "type"    => 'drisee',
	    "version" => 1,
	    "created" => strftime("%Y-%m-%dT%H:%M:%S", localtime) };
      
# parse drisee result files
my $stats = {};
if (open(FH, "<$log")) {
  my $i = 0;
  while (<FH>) {
    chomp;
    my ($key, $value) = split /\t/;
    $stats->{$key} = $value;
    if ($i == 5) { last; }
    $i++;
  }
  close FH;
} else {
  print STDERR "could not open logfile";
  exit 1;
}

my $drisee = [];
if (open(FH, "<$infile")) {
  while (<FH>) {
    chomp;
    my $row = [];
    @$row = split /\t/;
    push(@$drisee, $row);
  }
  close FH;
} else {
  print STDERR "could not open statsfile";
  exit 1;
}

$obj->{"total_errors"} = $stats->{"Drisee score"} ? $stats->{"Drisee score"} * 1.0 : undef;

if ($drisee && (@$drisee > 2) && ($drisee->[1][0] eq '#')) {
  $obj->{insertion_deletion} =  $drisee->[1][6] * 1.0;
  $obj->{substitution} = { A => $drisee->[1][1] * 1.0,
			   T => $drisee->[1][2] * 1.0,
			   C => $drisee->[1][3] * 1.0,
			   G => $drisee->[1][4] * 1.0,
			   N => $drisee->[1][5] * 1.0 };
  my $col_set = ['A', 'T', 'C', 'G', 'N', 'InDel'];
  my $rows = [];
  my $cols = [];
  my $data = [];
  map { push @$cols, $_.' match consensus sequence' } @$col_set;
  map { push @$cols, $_.' not match consensus sequence' } @$col_set;
  if ($drisee && (@$drisee > 2) && ($drisee->[0][0] eq '#')) {
    foreach my $row (@$drisee) {
      next if ($row->[0] eq '#');
      my @nums = map { int($_) } @$row;
      push @$rows, shift @nums;
      push @$data, [ @nums ];
    }
  }
  $obj->{count_profile} = { rows => $rows, columns => $cols, data => $data };
  
  my $rows2 = [];
  my $cols2 = [ @$col_set, 'Total' ];
  my $data2 = [];
  if ($drisee && (@$drisee > 2) && ($drisee->[0][0] eq '#')) {
    foreach my $row (@$drisee) {
      my $x = shift @$row;
      next if ($x eq '#');
      if (int($x) > 50) {
	my $sum = 0;
	map { $sum += $_; } @$row;
	my @per = map { sprintf("%.2f", 100 * (($_ * 1.0) / $sum)) * 1.0 } @$row;
	push @$rows2, int($x);
	my $psum = 0;
	map { $psum += $_; } @per[6..11];
	push @$data2, [ @per[6..11], sprintf("%.2f", $psum) * 1.0 ];
      }
    }
  }
  $obj->{percent_profile} = { rows => $rows2, columns => $cols2, data => $data2 };
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
  print FH $json->encode({ "type" => "drisee",
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
