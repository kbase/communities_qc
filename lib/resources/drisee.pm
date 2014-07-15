package resources::drisee;

# use basic packages and the config
use Conf;
use JSON;
use Data::Dumper;

my $workdir = $Conf::workdir;
my $shock = $Conf::shock_url;

my $json = new JSON;

use Dancer;

set serializer => 'JSON';
set port       => 7052;

use POSIX qw(strftime);

use resources::compute;

# STATUS CODES for reference
#
# Success
# 200 OK
# 201 Created
# 204 No Content
#
# In case of an error call this function:
#
# return_data("ERROR: $error_message", $status_code);
#
# Client Error
# 400 Bad Request
# 401 Unauthorized
# 404 Not Found
# 416 Requested range not satisfiable
#
# Server Error
# 500 Internal Server Error
# 501 Not Implemented
# 503 Service Unavailable

# global variables
my $rest;

# JSON RPC related variables
my $json_rpc = 0;
my $json_rpc_id = undef;
my $error_messages = { 400 => "Bad Request",
		       401 => "Unauthorized",
		       404 => "Not Found",
		       416 => "Request range not satisfiable",
		       500 => "Internal Server Error",
		       501 => "Not Implemented",
		       503 => "Service Unavailable",
		       -32602 => "Invalid params",
		       -32603 => "Internal error" };

# structural information about this resource
sub info {
  my $content = { 'name' => name(),
		  'url' => ($Conf::server_name || uri_for("/")).name(),
		  'description' => 'quality assessment of metagenomic sequence',
		  'type' => 'object', # this template is mainly designed for object resources
		  'requests' => [ { 'name'        => "info",
				    'request'     => ($Conf::server_name || uri_for("/")).name(),
				    'description' => "Returns description of parameters and attributes.",
				    'method'      => "GET",
				    'type'        => "synchronous",
				    'attributes'  => "self",
				    'parameters'  => {
						      'options'     => {},
						      'required'    => {},
						      'body'        => {} } },
				  { 'name'        => "compute",
				    'request'     => ($Conf::server_name || uri_for("/")).name()."/{ID}" ,				      
				    'description' => "computes quality assessment data of a metagenomic sequence",
				    'method'      => "POST" ,
				    'type'        => "asynchronous" ,  
				    'parameters'  => { 'options' => { 'direct_return' => [ [ 0, 'always return a status token' ],
											   [ 1, 'if the compute is done, return the result data' ] ] },
						       'required' => { 'id'=> [ 'string', 'id of the metagenome to be analyzed' ] },
						       'body'        => {} },
				    'attributes' => { 'id'      => [ 'string', 'id of the metagenome to be analyzed' ],
						      'status'  => [ 'string', 'status of the compute, one of [ waiting, running, error, complete ]' ],
						      'error'   => [ 'string', 'the error message if one ocurred, otherwise an empty string' ],
						      'time'    => [ 'string', 'computation time of the job at the time of the query' ] } },
				  
				  
				  
				  { 'name'        => "instance",
				    'request'     => ($Conf::server_name || uri_for("/")).name()."/{ID}",
				    'description' => "Returns a single object.",
				    'method'      => "GET" ,
				    'type'        => "synchronous" ,  
				    'attributes'  => attributes(),
				    'parameters'  => { 'options'     => {},
						       'required'    => { "id" => [ "string", "unique object identifier" ] },
						       'body'        => {} } },
				]
		};
  
  my $data = return_data($content);
  return $data;
}


# name of the resource
sub name {
  return "drisee";
}

# attributes of the resource
sub attributes {
  
  return {  "id"                 => [ "string" , "Unique ID of the sequence file calculated the drisee error from" ],
	    "version"            => [ "string" , "Version of the drisee score "],
	    "created"            => [ "date" , "Creation time for this drisee resource" ],
	    "total_errors"       => [ "float" , "cumulative drisee error"],
	    "insertion_delition" => [ "float" , "insertion deletion quotient" ],
	    "substitution"       => [ "hash", { "A" => [ "float" , "Error for substitution of A" ],
						"T" => [ "float" , "Error for substitution of T" ],
						"C" => [ "float" , "Error for substitution of V" ],
						"G" => [ "float" , "Error for substitution of G" ],
						"N" => [ "float" , "Error for substitution of N" ] } ],
	    "count_profile"      => [  ],
	    "percent_profile"    => [  ] }; 
}

# the resource is called with an id parameter
sub instance {
  my ($params) = @_;

  use LWP::UserAgent;
  my $ua = LWP::UserAgent->new();
  my $query_params = $params->{query_params};
  my $auth = "";
  my $user = "";
  if ($params->{token}) {
    $auth = '-H "Authorization: Globus-Goauthtoken '.$params->{token}.'" ';
    ($user) = $params->{token} =~ /^un=([^\|]+)/;
  }

  # check id format
  my $id = $rest->[0];
  if (! $id && scalar(@$rest)) {
    return return_data({"ERROR" => "invalid id format: ".$rest->[0]}, 400);
  }
  
  # try to get the result from shock
  my $ex = 'curl -s -X GET '.$auth.'"'.$Conf::shock_url.'?query&type=drisee&id='.$id.'"';
  my $data = `$ex`;
  $data = $json->decode($data);
  if ($data->{data} && scalar(@{$data->{data}})) {
    $data = $data->{data}->[0]->{id};
    $ex = 'curl -s -X GET '.$auth.'"'.$Conf::shock_url."/".$data.'?download"';
    $data = $json->decode(`$ex`);
    return return_data($data);
  }

  my $usable_id = $id;
  $usable_id =~ s/\|/_/;
  
  # check status
  if (($rest->[1] && $rest->[1] eq 'status') || ($params->{submethod} && $params->{submethod} eq 'status')) {
    return return_data(compute_status({ "id" => $id, "token" => $params->{token} }))
  }
  
  # check for compute
  if (($rest->[1] && $rest->[1] eq 'compute') || ($params->{submethod} && $params->{submethod} eq 'compute')) {
    my $uri = $Conf::shock_url."?query&type=metagenome&metagenome=$id&stage=upload";
    my $sequence_data = $json->decode($ua->get($uri)->content)->{data};
    my $node_id;
    if ($sequence_data) {
      foreach my $d (@$sequence_data) {
	if ($d->{file}->{name} =~ /\.gz$/) {
	  $node_id = $d->{id};
	  last;
	}
      }
      unless ($node_id) {
	return return_data({"ERROR" => "the sequence for the selected id is not available"}, 404);
      }
    } else {
      return return_data({"ERROR" => "the sequence for the selected id is not available"}, 404);
    }
    
    my $compute = submit({ resource => 'drisee',
			   id => $id,
			   token => $params->{token},
			   template => &template($shock, $node_id, $id, $user) });
        
    # return the status
    return return_data($compute)
      
  }
}

#################################################################################
# generic functions - do not edit below this line if this resource is using PPO #
#################################################################################

# method initially called from the api module
sub request {
  my ($params) = @_;

  $rest = $params->{rest_parameters} || [];

  if ($params->{json_rpc}) {
    $json_rpc = $params->{json_rpc};
    if (exists($params->{json_rpc_id})) {
      $json_rpc_id = $params->{json_rpc_id};
    }
  }

  # check for parameters
  if (scalar(@$rest) == 0) {
    return info();
  }

  # check for id
  if (scalar(@$rest)) {
    return instance($params);
  }
}

# print the actual data output
sub return_data {
  my ($data, $error) = @_;

  # default status is OK
  my $status = 200;  
  
  # if the result is an empty array, status is 204
  if (ref($data) eq "ARRAY" && scalar(@$data) == 0) {
    $status = 204;
  }

  # if an error is passed, change the return format to text 
  # and change the status code to the error code passed
  if ($error) {
    $status = $error;
  }

  # check for remote procedure call
  if ($json_rpc) {
    
    # only reply if this is not a notification
#    if (defined($json_rpc_id)) { 
      if ($error) {

	my $error_code = $status;
	if ($status == 400) {
	  $status = -32602;
	} elsif ($status == 500) {
	  $status = -32603;
	}

	# there was an error
	$data = { jsonrpc => "2.0",
		  error => { code => $error_code,
			     message => $error_messages->{$status},
			     data => $data },
		  id => $json_rpc_id };

      } else {
	
	# normal result
	$data = { jsonrpc => "2.0",
		  result => [$data],
		  id => $json_rpc_id };
      }

      status(200);
      header "Access-Control-Allow-Origin" => "*";
      return $data;
#    }
  } else {
      status($status);
      header "Access-Control-Allow-Origin" => "*";
      return $data;
  }
}

################
# AWE template #
################

sub template {
  my ($shock, $node, $id, $user) = @_;

  $shock =~ s/\/node//;

  return {
	  "info" => {
		     "pipeline" => $Conf::awe_pipeline,
		     "name" => "DRISEE_$id",
		     "project" => $Conf::awe_project,
		     "user" => $user,
		     "clientgroups" => $Conf::awe_clientgroups
		    },
	  "tasks" => [
		      {
		       "cmd" => {
				 "args" => "--input \@seqs.gz --output seqs.fasta",
				 "description" => "unzip the sequence file",
				 "name" => "unpack"
				},
		       "dependsOn" => [ ],
		       "inputs" => {
				    "seqs.gz" => {
						 "host" => $shock,
						 "node" => $node
						}
				   },
		       "outputs" => {
				     "seqs.fasta" => {
						      "host" => $shock,
						      "node" => "-"
						     }
				     
				    },
		       "taskid" => "0",
		       "totalwork" => 1
		      },
		      {
		       "cmd" => {
				 "args" => "-f -l logfile \@seqs.fasta seqs.stats -d . -g ".$Conf::libdir."/adapterDB.fna",
				 "description" => "create a DRISEE profile from a sequence file",
				 "name" => "drisee"
				},
		       "dependsOn" => [ "0" ],
		       "inputs" => {
				    "seqs.fasta" => {
						     "host" => $shock,
						     "node" => "-",
						     "origin" => "0"
						    }
				   },
		       "outputs" => {
				     "seqs.stats" => {
						      "host" => $shock,
						      "node" => "-"
						     },
				     "logfile" => {
						   "host" => $shock,
						   "node" => "-"
						  }
				    },
		       "taskid" => "1",
		       "totalwork" => 1
		      },
		      {
		       "cmd" => {
				 "args" => "-file \@seqs.stats -log \@logfile -id $id",
				 "description" => "convert DRISEE profile to JSON",
				 "name" => "drisee2json"
				},
		       "dependsOn" => [ "1" ],
		       "inputs" => {
				    "seqs.stats" => {
						     "host" => $shock,
						     "node" => "-",
						     "origin" => "1"
						    },
				    "logfile" => {
						  "host" => $shock,
						  "node" => "-",
						  "origin" => "1"
						 }
				   },
		       "outputs" => {
				     "seqs.stats.json" => {
							   "host" => $shock,
							   "node" => "-",
							   "attrfile" => "attributes"
							  }
				    },
		       "taskid" => "2",
		       "totalwork" => 1
		      }
		     ]
	 };
}

# enable hash-resolving in the JSON->encode function
sub TO_JSON { return { %{ shift() } }; }

1;
