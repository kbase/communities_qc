package MicrobialCommunitiesQCClient;

use JSON::RPC::Client;
use strict;
use Data::Dumper;
use URI;
use Bio::KBase::Exceptions;

# Client version should match Impl version
# This is a Semantic Version number,
# http://semver.org
our $VERSION = "0.1.0";

=head1 NAME

MicrobialCommunitiesQCClient

=head1 DESCRIPTION


RESTful Microbial Communities object and resource API


=cut

sub new
{
    my($class, $url, @args) = @_;
    

    my $self = {
	client => MicrobialCommunitiesQCClient::RpcClient->new,
	url => $url,
    };


    my $ua = $self->{client}->ua;	 
    my $timeout = $ENV{CDMI_TIMEOUT} || (30 * 60);	 
    $ua->timeout($timeout);
    bless $self, $class;
    #    $self->_validate_version();
    return $self;
}




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
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_drisee_compute (received $n, expecting 1)");
    }
    {
	my($GetDriseeComputeParams) = @args;

	my @_bad_arguments;
        (ref($GetDriseeComputeParams) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"GetDriseeComputeParams\" (value was \"$GetDriseeComputeParams\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_drisee_compute:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_drisee_compute');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "MicrobialCommunitiesQC.get_drisee_compute",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{code},
					       method_name => 'get_drisee_compute',
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_drisee_compute",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_drisee_compute',
				       );
    }
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
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_drisee_instance (received $n, expecting 1)");
    }
    {
	my($GetDriseeInstanceParams) = @args;

	my @_bad_arguments;
        (ref($GetDriseeInstanceParams) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"GetDriseeInstanceParams\" (value was \"$GetDriseeInstanceParams\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_drisee_instance:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_drisee_instance');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "MicrobialCommunitiesQC.get_drisee_instance",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{code},
					       method_name => 'get_drisee_instance',
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_drisee_instance",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_drisee_instance',
				       );
    }
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
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_histogram_compute (received $n, expecting 1)");
    }
    {
	my($GetHistogramComputeParams) = @args;

	my @_bad_arguments;
        (ref($GetHistogramComputeParams) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"GetHistogramComputeParams\" (value was \"$GetHistogramComputeParams\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_histogram_compute:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_histogram_compute');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "MicrobialCommunitiesQC.get_histogram_compute",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{code},
					       method_name => 'get_histogram_compute',
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_histogram_compute",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_histogram_compute',
				       );
    }
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
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_histogram_instance (received $n, expecting 1)");
    }
    {
	my($GetHistogramInstanceParams) = @args;

	my @_bad_arguments;
        (ref($GetHistogramInstanceParams) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"GetHistogramInstanceParams\" (value was \"$GetHistogramInstanceParams\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_histogram_instance:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_histogram_instance');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "MicrobialCommunitiesQC.get_histogram_instance",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{code},
					       method_name => 'get_histogram_instance',
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_histogram_instance",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_histogram_instance',
				       );
    }
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
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_kmer_compute (received $n, expecting 1)");
    }
    {
	my($GetKmerComputeParams) = @args;

	my @_bad_arguments;
        (ref($GetKmerComputeParams) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"GetKmerComputeParams\" (value was \"$GetKmerComputeParams\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_kmer_compute:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_kmer_compute');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "MicrobialCommunitiesQC.get_kmer_compute",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{code},
					       method_name => 'get_kmer_compute',
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_kmer_compute",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_kmer_compute',
				       );
    }
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
    my($self, @args) = @_;

# Authentication: none

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_kmer_instance (received $n, expecting 1)");
    }
    {
	my($GetKmerInstanceParams) = @args;

	my @_bad_arguments;
        (ref($GetKmerInstanceParams) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"GetKmerInstanceParams\" (value was \"$GetKmerInstanceParams\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_kmer_instance:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_kmer_instance');
	}
    }

    my $result = $self->{client}->call($self->{url}, {
	method => "MicrobialCommunitiesQC.get_kmer_instance",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{code},
					       method_name => 'get_kmer_instance',
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_kmer_instance",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_kmer_instance',
				       );
    }
}



sub version {
    my ($self) = @_;
    my $result = $self->{client}->call($self->{url}, {
        method => "MicrobialCommunitiesQC.version",
        params => [],
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(
                error => $result->error_message,
                code => $result->content->{code},
                method_name => 'get_kmer_instance',
            );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(
            error => "Error invoking method get_kmer_instance",
            status_line => $self->{client}->status_line,
            method_name => 'get_kmer_instance',
        );
    }
}

sub _validate_version {
    my ($self) = @_;
    my $svr_version = $self->version();
    my $client_version = $VERSION;
    my ($cMajor, $cMinor) = split(/\./, $client_version);
    my ($sMajor, $sMinor) = split(/\./, $svr_version);
    if ($sMajor != $cMajor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Major version numbers differ.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor < $cMinor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Client minor version greater than Server minor version.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor > $cMinor) {
        warn "New client version available for MicrobialCommunitiesQCClient\n";
    }
    if ($sMajor == 0) {
        warn "MicrobialCommunitiesQCClient version is $svr_version. API subject to change.\n";
    }
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

package MicrobialCommunitiesQCClient::RpcClient;
use base 'JSON::RPC::Client';

#
# Override JSON::RPC::Client::call because it doesn't handle error returns properly.
#

sub call {
    my ($self, $uri, $obj) = @_;
    my $result;

    if ($uri =~ /\?/) {
       $result = $self->_get($uri);
    }
    else {
        Carp::croak "not hashref." unless (ref $obj eq 'HASH');
        $result = $self->_post($uri, $obj);
    }

    my $service = $obj->{method} =~ /^system\./ if ( $obj );

    $self->status_line($result->status_line);

    if ($result->is_success) {

        return unless($result->content); # notification?

        if ($service) {
            return JSON::RPC::ServiceObject->new($result, $self->json);
        }

        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    elsif ($result->content_type eq 'application/json')
    {
        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    else {
        return;
    }
}


sub _post {
    my ($self, $uri, $obj) = @_;
    my $json = $self->json;

    $obj->{version} ||= $self->{version} || '1.1';

    if ($obj->{version} eq '1.0') {
        delete $obj->{version};
        if (exists $obj->{id}) {
            $self->id($obj->{id}) if ($obj->{id}); # if undef, it is notification.
        }
        else {
            $obj->{id} = $self->id || ($self->id('JSON::RPC::Client'));
        }
    }
    else {
        # $obj->{id} = $self->id if (defined $self->id);
	# Assign a random number to the id if one hasn't been set
	$obj->{id} = (defined $self->id) ? $self->id : substr(rand(),2);
    }

    my $content = $json->encode($obj);

    $self->ua->post(
        $uri,
        Content_Type   => $self->{content_type},
        Content        => $content,
        Accept         => 'application/json',
	($self->{token} ? (Authorization => $self->{token}) : ()),
    );
}



1;
