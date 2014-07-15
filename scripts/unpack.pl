use strict;
use warnings;

use Getopt::Long;

my $input  = "";
my $output = "";

GetOptions ( 'input=s' => \$input,
	     'output=s' => \$output );

`gunzip -c $input > $output`;

print STDOUT "success\n";

exit 0;
