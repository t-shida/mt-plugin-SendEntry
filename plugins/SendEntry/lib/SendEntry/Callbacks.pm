package SendEntry::Callbacks;

use strict;
use warnings;

use MT;
use MT::Log;
use LWP::UserAgent;
use HTTP::Request;
use JSON;
#use Data::Dumper;

sub send_entry {
  my ($cb, $app, $obj, $org_obj) = @_;
  my $mt = new MT;

  return if defined($org_obj->id);

  my $api_url = $mt->config->se_mt_api_url;
  my $username = $mt->config->se_mt_username;
  my $password = $mt->config->se_mt_password;
  my $blog_id = $mt->config->se_mt_blog_id;
  my $client_id = 'test';
  my $res;
  my $json;

  my $lwp = LWP::UserAgent->new;
  $lwp->timeout(20);

  # authentication
  $res = $lwp->post(
    "$api_url/v1/authentication",{
      username => $username,
      password => $password,
      clientId => $client_id
    }
  );
  $json = from_json($res->content);
  my $token = $json->{accessToken};
  if(! $token){
    write_log('error authentication');
    return;
  }

  # send
  my $request = HTTP::Request->new('POST',"$api_url/v1/sites/$blog_id/entries");
  $request->header('X-MT-Authorization' => "MTAuth accessToken=$token");
  my $params = {
    entry => encode_json({ 
      title => $obj->title,
      body => $obj->text,
      status => 'Publish',
    })
  };
  $request->content(join('&', map{$_.'='.$params->{$_}} keys %$params));
  $res = $lwp->request($request);
  $json = from_json($res->content);
  if(! $json->{id}){
    write_log('error send');
    return;
  }

  #write_log(Dumper $obj);
}

sub write_log{
  my ($msg, $class) = @_;
  return unless defined($msg);

  my $log = new MT::Log;
  $log->message($msg);
  $log->level(MT::Log::DEBUG());
  $log->class($class) if $class;
  $log->save or die $log->errstr;
}

1;
