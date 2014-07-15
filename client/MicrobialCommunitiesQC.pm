package MicrobialCommunitiesQC;
use strict;
use Bio::KBase::Exceptions;
# Use Semantic Versioning (2.0.0-rc.1)
# http://semver.org 
our $VERSION = "0.1.0";

=head1 NAME

MicrobialCommunitiesQC

=head1 DESCRIPTION

RESTful Microbial Communities object and resource API

=cut

#BEGIN_HEADER
#END_HEADER

sub new
{
    my($class, @args) = @_;
    my $self = {
    };
    bless $self, $class;
    #BEGIN_CONSTRUCTOR
    #END_CONSTRUCTOR

    if ($self->can('_init_instance'))
    {
	$self->_init_instance();
    }
    return $self;
}

=head1 METHODS



=head2 get_drisee_compute

  $return = $obj->get_drisee_compute($GetDriseeComputeParams)

=over 4

=item Parameter and return types

=begin html

<pre>
$GetDriseeComputeParams is a MicrobialCommunitiesQC.GetDriseeComputeParams
$return is a MicrobialCommunitiesQC.DriseeCompute
GetDriseeComputeParams is a reference to a hash where the following keys are defined:
	id has a value which is a string
DriseeCompute is a reference to a hash where the following keys are defined:
	time has a value which is a string
	status has a value which is a string
	error has a value which is a string
	id has a value which is a string

</pre>

=end html

=begin text

$GetDriseeComputeParams is a MicrobialCommunitiesQC.GetDriseeComputeParams
$return is a MicrobialCommunitiesQC.DriseeCompute
GetDriseeComputeParams is a reference to a hash where the following keys are defined:
	id has a value which is a string
DriseeCompute is a reference to a hash where the following keys are defined:
	time has a value which is a string
	status has a value which is a string
	error has a value which is a string
	id has a value which is a string


=end text



=item Description

quality assessment of metagenomic sequence
computes quality assessment data of a metagenomic sequence

=back

=cut

sub get_drisee_compute
{
    my $self = shift;
    my($GetDriseeComputeParams) = @_;

    my @_bad_arguments;
    (ref($GetDriseeComputeParams) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"GetDriseeComputeParams\" (value was \"$GetDriseeComputeParams\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to get_drisee_compute:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_drisee_compute');
    }

    my $ctx = $MicrobialCommunitiesQCServer::CallContext;
    my($return);
    #BEGIN get_drisee_compute
    #END get_drisee_compute
    my @_bad_returns;
    (ref($return) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"return\" (value was \"$return\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to get_drisee_compute:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_drisee_compute');
    }
    return($return);
}




=head2 get_drisee_instance

  $return = $obj->get_drisee_instance($GetDriseeInstanceParams)

=over 4

=item Parameter and return types

=begin html

<pre>
$GetDriseeInstanceParams is a MicrobialCommunitiesQC.GetDriseeInstanceParams
$return is a MicrobialCommunitiesQC.DriseeInstance
GetDriseeInstanceParams is a reference to a hash where the following keys are defined:
	id has a value which is a string
DriseeInstance is a reference to a hash where the following keys are defined:
	version has a value which is a string
	substitution has a value which is a reference to a hash where the key is a string and the value is a string
	insertion_delition has a value which is a float
	created has a value which is a string
	id has a value which is a string
	total_errors has a value which is a float

</pre>

=end html

=begin text

$GetDriseeInstanceParams is a MicrobialCommunitiesQC.GetDriseeInstanceParams
$return is a MicrobialCommunitiesQC.DriseeInstance
GetDriseeInstanceParams is a reference to a hash where the following keys are defined:
	id has a value which is a string
DriseeInstance is a reference to a hash where the following keys are defined:
	version has a value which is a string
	substitution has a value which is a reference to a hash where the key is a string and the value is a string
	insertion_delition has a value which is a float
	created has a value which is a string
	id has a value which is a string
	total_errors has a value which is a float


=end text



=item Description

quality assessment of metagenomic sequence
Returns a single object.

=back

=cut

sub get_drisee_instance
{
    my $self = shift;
    my($GetDriseeInstanceParams) = @_;

    my @_bad_arguments;
    (ref($GetDriseeInstanceParams) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"GetDriseeInstanceParams\" (value was \"$GetDriseeInstanceParams\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to get_drisee_instance:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_drisee_instance');
    }

    my $ctx = $MicrobialCommunitiesQCServer::CallContext;
    my($return);
    #BEGIN get_drisee_instance
    #END get_drisee_instance
    my @_bad_returns;
    (ref($return) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"return\" (value was \"$return\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to get_drisee_instance:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_drisee_instance');
    }
    return($return);
}




=head2 get_histogram_compute

  $return = $obj->get_histogram_compute($GetHistogramComputeParams)

=over 4

=item Parameter and return types

=begin html

<pre>
$GetHistogramComputeParams is a MicrobialCommunitiesQC.GetHistogramComputeParams
$return is a MicrobialCommunitiesQC.HistogramCompute
GetHistogramComputeParams is a reference to a hash where the following keys are defined:
	basepairs has a value which is an int
	id has a value which is a string
	sequences has a value which is an int
HistogramCompute is a reference to a hash where the following keys are defined:
	time has a value which is a string
	status has a value which is a string
	error has a value which is a string
	id has a value which is a string

</pre>

=end html

=begin text

$GetHistogramComputeParams is a MicrobialCommunitiesQC.GetHistogramComputeParams
$return is a MicrobialCommunitiesQC.HistogramCompute
GetHistogramComputeParams is a reference to a hash where the following keys are defined:
	basepairs has a value which is an int
	id has a value which is a string
	sequences has a value which is an int
HistogramCompute is a reference to a hash where the following keys are defined:
	time has a value which is a string
	status has a value which is a string
	error has a value which is a string
	id has a value which is a string


=end text



=item Description

quality assessment of metagenomic sequence
computes quality assessment data of a metagenomic sequence

=back

=cut

sub get_histogram_compute
{
    my $self = shift;
    my($GetHistogramComputeParams) = @_;

    my @_bad_arguments;
    (ref($GetHistogramComputeParams) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"GetHistogramComputeParams\" (value was \"$GetHistogramComputeParams\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to get_histogram_compute:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_histogram_compute');
    }

    my $ctx = $MicrobialCommunitiesQCServer::CallContext;
    my($return);
    #BEGIN get_histogram_compute
    #END get_histogram_compute
    my @_bad_returns;
    (ref($return) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"return\" (value was \"$return\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to get_histogram_compute:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_histogram_compute');
    }
    return($return);
}




=head2 get_histogram_instance

  $return = $obj->get_histogram_instance($GetHistogramInstanceParams)

=over 4

=item Parameter and return types

=begin html

<pre>
$GetHistogramInstanceParams is a MicrobialCommunitiesQC.GetHistogramInstanceParams
$return is a MicrobialCommunitiesQC.HistogramInstance
GetHistogramInstanceParams is a reference to a hash where the following keys are defined:
	id has a value which is a string
HistogramInstance is a reference to a hash where the following keys are defined:
	created has a value which is a string
	version has a value which is a string
	id has a value which is a string

</pre>

=end html

=begin text

$GetHistogramInstanceParams is a MicrobialCommunitiesQC.GetHistogramInstanceParams
$return is a MicrobialCommunitiesQC.HistogramInstance
GetHistogramInstanceParams is a reference to a hash where the following keys are defined:
	id has a value which is a string
HistogramInstance is a reference to a hash where the following keys are defined:
	created has a value which is a string
	version has a value which is a string
	id has a value which is a string


=end text



=item Description

quality assessment of metagenomic sequence
Returns a single object.

=back

=cut

sub get_histogram_instance
{
    my $self = shift;
    my($GetHistogramInstanceParams) = @_;

    my @_bad_arguments;
    (ref($GetHistogramInstanceParams) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"GetHistogramInstanceParams\" (value was \"$GetHistogramInstanceParams\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to get_histogram_instance:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_histogram_instance');
    }

    my $ctx = $MicrobialCommunitiesQCServer::CallContext;
    my($return);
    #BEGIN get_histogram_instance
    #END get_histogram_instance
    my @_bad_returns;
    (ref($return) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"return\" (value was \"$return\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to get_histogram_instance:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_histogram_instance');
    }
    return($return);
}




=head2 get_kmer_compute

  $return = $obj->get_kmer_compute($GetKmerComputeParams)

=over 4

=item Parameter and return types

=begin html

<pre>
$GetKmerComputeParams is a MicrobialCommunitiesQC.GetKmerComputeParams
$return is a MicrobialCommunitiesQC.KmerCompute
GetKmerComputeParams is a reference to a hash where the following keys are defined:
	kmer_length has a value which is an int
	id has a value which is a string
KmerCompute is a reference to a hash where the following keys are defined:
	time has a value which is a string
	status has a value which is a string
	error has a value which is a string
	id has a value which is a string

</pre>

=end html

=begin text

$GetKmerComputeParams is a MicrobialCommunitiesQC.GetKmerComputeParams
$return is a MicrobialCommunitiesQC.KmerCompute
GetKmerComputeParams is a reference to a hash where the following keys are defined:
	kmer_length has a value which is an int
	id has a value which is a string
KmerCompute is a reference to a hash where the following keys are defined:
	time has a value which is a string
	status has a value which is a string
	error has a value which is a string
	id has a value which is a string


=end text



=item Description

quality assessment of metagenomic sequence
computes quality assessment data of a metagenomic sequence

=back

=cut

sub get_kmer_compute
{
    my $self = shift;
    my($GetKmerComputeParams) = @_;

    my @_bad_arguments;
    (ref($GetKmerComputeParams) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"GetKmerComputeParams\" (value was \"$GetKmerComputeParams\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to get_kmer_compute:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_kmer_compute');
    }

    my $ctx = $MicrobialCommunitiesQCServer::CallContext;
    my($return);
    #BEGIN get_kmer_compute
    #END get_kmer_compute
    my @_bad_returns;
    (ref($return) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"return\" (value was \"$return\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to get_kmer_compute:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_kmer_compute');
    }
    return($return);
}




=head2 get_kmer_instance

  $return = $obj->get_kmer_instance($GetKmerInstanceParams)

=over 4

=item Parameter and return types

=begin html

<pre>
$GetKmerInstanceParams is a MicrobialCommunitiesQC.GetKmerInstanceParams
$return is a MicrobialCommunitiesQC.KmerInstance
GetKmerInstanceParams is a reference to a hash where the following keys are defined:
	id has a value which is a string
KmerInstance is a reference to a hash where the following keys are defined:
	created has a value which is a string
	version has a value which is a string
	id has a value which is a string

</pre>

=end html

=begin text

$GetKmerInstanceParams is a MicrobialCommunitiesQC.GetKmerInstanceParams
$return is a MicrobialCommunitiesQC.KmerInstance
GetKmerInstanceParams is a reference to a hash where the following keys are defined:
	id has a value which is a string
KmerInstance is a reference to a hash where the following keys are defined:
	created has a value which is a string
	version has a value which is a string
	id has a value which is a string


=end text



=item Description

quality assessment of metagenomic sequence
Returns a single object.

=back

=cut

sub get_kmer_instance
{
    my $self = shift;
    my($GetKmerInstanceParams) = @_;

    my @_bad_arguments;
    (ref($GetKmerInstanceParams) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"GetKmerInstanceParams\" (value was \"$GetKmerInstanceParams\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to get_kmer_instance:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_kmer_instance');
    }

    my $ctx = $MicrobialCommunitiesQCServer::CallContext;
    my($return);
    #BEGIN get_kmer_instance
    #END get_kmer_instance
    my @_bad_returns;
    (ref($return) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"return\" (value was \"$return\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to get_kmer_instance:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_kmer_instance');
    }
    return($return);
}




=head2 version 

  $return = $obj->version()

=over 4

=item Parameter and return types

=begin html

<pre>
$return is a string
</pre>

=end html

=begin text

$return is a string

=end text

=item Description

Return the module version. This is a Semantic Versioning number.

=back

=cut

sub version {
    return $VERSION;
}

=head1 TYPES



=head2 GetDriseeComputeParams

=over 4



=item Description

id of the metagenome to be analyzed


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
id has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
id has a value which is a string


=end text

=back



=head2 DriseeCompute

=over 4



=item Description

id of the metagenome to be analyzed


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
time has a value which is a string
status has a value which is a string
error has a value which is a string
id has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
time has a value which is a string
status has a value which is a string
error has a value which is a string
id has a value which is a string


=end text

=back



=head2 GetDriseeInstanceParams

=over 4



=item Description

unique object identifier


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
id has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
id has a value which is a string


=end text

=back



=head2 DriseeInstance

=over 4



=item Description

cumulative drisee error


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
version has a value which is a string
substitution has a value which is a reference to a hash where the key is a string and the value is a string
insertion_delition has a value which is a float
created has a value which is a string
id has a value which is a string
total_errors has a value which is a float

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
version has a value which is a string
substitution has a value which is a reference to a hash where the key is a string and the value is a string
insertion_delition has a value which is a float
created has a value which is a string
id has a value which is a string
total_errors has a value which is a float


=end text

=back



=head2 GetHistogramComputeParams

=over 4



=item Description

maximum number of sequences to be analyzed, default 100000


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
basepairs has a value which is an int
id has a value which is a string
sequences has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
basepairs has a value which is an int
id has a value which is a string
sequences has a value which is an int


=end text

=back



=head2 HistogramCompute

=over 4



=item Description

id of the metagenome to be analyzed


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
time has a value which is a string
status has a value which is a string
error has a value which is a string
id has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
time has a value which is a string
status has a value which is a string
error has a value which is a string
id has a value which is a string


=end text

=back



=head2 GetHistogramInstanceParams

=over 4



=item Description

unique object identifier


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
id has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
id has a value which is a string


=end text

=back



=head2 HistogramInstance

=over 4



=item Description

Unique ID of the sequence file calculated the drisee error from


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
created has a value which is a string
version has a value which is a string
id has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
created has a value which is a string
version has a value which is a string
id has a value which is a string


=end text

=back



=head2 GetKmerComputeParams

=over 4



=item Description

id of the metagenome to be analyzed


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
kmer_length has a value which is an int
id has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
kmer_length has a value which is an int
id has a value which is a string


=end text

=back



=head2 KmerCompute

=over 4



=item Description

id of the metagenome to be analyzed


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
time has a value which is a string
status has a value which is a string
error has a value which is a string
id has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
time has a value which is a string
status has a value which is a string
error has a value which is a string
id has a value which is a string


=end text

=back



=head2 GetKmerInstanceParams

=over 4



=item Description

unique object identifier


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
id has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
id has a value which is a string


=end text

=back



=head2 KmerInstance

=over 4



=item Description

Unique ID of the sequence file calculated the drisee error from


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
created has a value which is a string
version has a value which is a string
id has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
created has a value which is a string
version has a value which is a string
id has a value which is a string


=end text

=back



=cut

1;
