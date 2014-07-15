use JSON;

use Conf;
use Data::Dumper;
use Dancer;

set serializer => 'JSON';
set port       => 7052;

any qr{[\/\w\d\.\|\-]+} => sub {

  if (lc(request->method()) eq "options") {
    header "status" => 200;
    header "Access-Control-Allow-Origin" => "*";
    header "Access-Control-Allow-Headers" => "Authorization";
    header "Access-Control-Allow-Methods" => "POST, GET, OPTIONS";
    return "";
  }
  
    # create json object
    my $json = new JSON;
    $json = $json->utf8();

    # check for authentication
    my $token;
    if (request->header('Authorization')) {
      $token = request->header('Authorization');
      if ($token =~ /Globus-Goauthtoken/) {
	$token =~ s/Globus-Goauthtoken\s+(.*)/$1/;
      } else {
	$token = undef;
      }
    }

  # get the rest parameters
  my $url = request->uri_base() . request->path();
  my $sn = $Conf::server_name;
  if ($sn && $url =~ /^$sn/) {
    $url =~ s/^$sn(.*)$/$1/;
  } else {
    $url = request->path();
  }
  my @rest_parameters = split /\//, $url;
  #shift @rest_parameters;
  my $p = params;
  my $query_params = {};
    %$query_params = map { $_ => param $_ } keys(%$p);

    # get the resource
    my $resource = shift @rest_parameters;
#  if (lc(request->method()) eq 'post') {
#    push @rest_parameters, 'compute';
#  }

    # get resource list
    my $resources = [];
    my $resources_hash = {};
    my $resource_path = $Conf::resources;
    if (! $resource_path) {
      header "status" => 500;
      header "Access-Control-Allow-Origin" => "*";
      return "ERROR" => "resource directory not found";
    }

    if (opendir(my $dh, $resource_path)) {
	my @res = grep { -f "$resource_path/$_" } readdir($dh);
	closedir $dh;
	@$resources = map { my ($r) = $_ =~ /^(.*)\.pm$/; $r ? $r: (); } @res;
	@$resources = map { $_ eq 'compute' ? () : $_ } @$resources;
	%$resources_hash = map { $_ => 1 } @$resources;
	
    } else {
	if (request->is_post() && ! $resource) {
	  header "status" => 200;
	  header "Access-Control-Allow-Origin" => "*";
	  return { jsonrpc => "2.0",
		   id => undef,
		   error => {  code => -32603,
			       message => "Internal error",
			       data => "resource directory offline" } };
	} else {
	  header "status" => 500;
	  header "Access-Control-Allow-Origin" => "*";
	  return "ERROR" => "resource directory offline";
	}
    }
    
    # check for json rpc
    my $json_rpc;
    if (request->is_post()) {
      $json_rpc = request->body();
    }
    my $json_rpc_id;
    my $rpc_request;
    my $submethod;
    if ($json_rpc && ! $resource) {
	eval { $rpc_request = $json->decode($json_rpc) };
	if ($@) {
	  header "status" => 200;
	  header "Access-Control-Allow-Origin" => "*";
	  return { jsonrpc => "2.0",
		   id => undef,
		   error => {  code => -32700,
			       message => "Parse error",
			       data => $@ } };
	}
	
	$json_rpc_id = $rpc_request->{id};
	my $params = $rpc_request->{params};
	if (ref($params) eq 'ARRAY' && ref($params->[0]) eq 'HASH') {
	    $params = $params->[0];
	}
	unless (ref($params) eq 'HASH') {
	  header "status" => 200;
	  header "Access-Control-Allow-Origin" => "*";
	  return { jsonrpc => "2.0",
		   id => undef,
		   error => {  code => -32602,
			       message => "Invalid params",
			       data => "only named parameters are accepted" } };
	}
	foreach my $key (keys(%$params)) {
	    if ($key eq 'id') {
		@rest_parameters = ( $params->{$key} );
	    } else {
		$query_params->{$key} = $params->{$key};
	    }
	}
	(undef, undef, $resource, $submethod) = $rpc_request->{method} =~ /^(\w+\.)?(get|post|delete|put)_(\w+)_(\w+)$/;
	$json_rpc = 1;
    }
    
    # if a resource is passed, call the resources module
    if ($resource) {
	if ($resources_hash->{$resource}) {
	    my $retv = { "ERROR" => "resource invocation failed" };
	    my $query = "use resources::$resource; \$retv = resources::".$resource."::request( { 'rest_parameters' => \\\@rest_parameters, 'json_rpc' => \$json_rpc, 'json_rpc_id' => \$json_rpc_id, 'submethod' => \$submethod, 'query_params' => \$query_params, 'token' => \$token } );";
	    eval $query;
	    if ($@) {
		header "status" => 500;
		header "Access-Control-Allow-Origin" => "*";
		return "ERROR" => "resource request failed: $@";
	    } else {
		return $retv;
	    }
	} else {
	    header "status" => 400;
	    header "Access-Control-Allow-Origin" => "*";
	    return "ERROR" => "resource '$resource' does not exist";
	}
    }
    # we are called without a resource, return API information
    else {
      my $base_url = $Conf::server_name || uri_for("/");
      my @resource_objects = map { { 'name' => $_, 'url' => $base_url.$_ } } sort @$resources;
      my $content = { version => 1,
		      service => 'Microbial Communities QC',
		      url => $base_url."",
		      description => "RESTful Microbial Communities object and resource API",
		      contact => 'support@kbase.us',
		      resources => \@resource_objects };
      header "status" => 200;
      header "Access-Control-Allow-Origin" => "*";

      return $content;
    }
};

start;

sub TO_JSON { return { %{ shift() } }; }

1;
