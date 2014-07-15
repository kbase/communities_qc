package resources::compute;

use strict;
use warnings;

use Conf;
use JSON;

our @ISA = qw( Exporter );
our @EXPORT = qw( compute_status submit delete_job );

use Data::Dumper;

my $json = new JSON;

sub compute_status {
  my ($params) = @_;

  my $data = {};
  if ($params->{id}) {
    my $exec = 'curl -s -X GET -H "Datatoken: '.$params->{token}.'" '.$Conf::awe_url ."/job/".$params->{id};
    eval { $data = $json->decode(`$exec`); };
    if ($data->{data}) {
      $data = $data->{data};
    }
  }

  my $status = $data->{state} || "error";
  my $error = $data->{notes} || "";
  my $time = { submitted => $data->{info}->{submittime} || 0,
	       started => $data->{info}->{startedtime} || 0,
	       completed => $data->{info}->{completedtime} ||0 };


  return { status => $status,
	   id     => $data->{id} || $params->{id},
	   info   => $data->{info} ? { name => $data->{info}->{name},
				       tasks_remaining => $data->{remaintasks},
				       current_task => $data->{tasks}->[scalar(@{$data->{tasks}}) - $data->{remaintasks}]->{cmd}->{description},
				       started => $data->{tasks}->[scalar(@{$data->{tasks}}) - $data->{remaintasks}]->{startedtime} } : {}, 
	   error  => $error,
	   time   => $time };
}

sub submit {
  my ($params) = @_;

  my $resource = $params->{resource};
  my $id = $params->{id};
  my $template = $params->{template};
  my $tfn = $resource.$id;

  unless (-f $tfn) {
    if (open(FH, ">".$tfn)) {
      print FH $json->encode($template);
      close FH;
    } else {
       print STDERR "could not open workflow file\n";
    }
  }

  if ($resource && $id && $template) {
    my $data = {};
    my $exec = 'curl -s -X POST -H "Datatoken: '.$params->{token}.'" -F "upload=@'.$tfn.'" '.$Conf::awe_url ."/job";
    eval { $data = $json->decode(`$exec`); };
    unlink $tfn;

    if ($data->{data}) {
      $data = $data->{data};
      $params->{id} = $data->{id};
    }
    
    return &compute_status($params);
  } else {
    die "invalid parameters";
  }
}

sub request {
  return { name => 'compute', requests => [] };
}

sub delete_job {
  my ($params) = @_;

  my $resource = $params->{resource};
  my $id = $params->{id};

  if ($resource && $id) {
    my $jobexists = 1;
    if ($jobexists) {
      return "job deleted";
    } else {
      return "job does not exist";
    }
  } else {
    die "invalid parameters";
  }
}

1;

# enable hash-resolving in the JSON->encode function
sub TO_JSON { return { %{ shift() } }; }
