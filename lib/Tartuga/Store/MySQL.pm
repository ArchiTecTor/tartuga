package Tartuga::Store::MySQL;

our $VERSION = 0.001;

use Tartuga::Store::Base;
use Tartuga::Errors::InitError;

use Try::Tiny;

our @REQUIRE = qw(user password);

use base "Tartuga::Store::Base";

use DBI;

sub init {
    
    my $self = shift;
    
    my $database = $self->{database} || $Tartuga::Store::Base::DATABASE;
    
    my $host = $self->{host} || '127.0.0.1';
    
    my $user = $self->{user};
    
    my $password = $self->{password};
    
    $self->{dbh} = try {
        DBI->connect("DBI:mysql:database=$database;host=$host",$user, $password, {RaiseError => 1});
    }
    catch {
        die(new Tartuga::Errors::InitError("failed init store MySQL",$_));
    };
}


sub DESTROY {
    
    my $self = shift;
    
    $self->{dbh}->disconnect() if($self->{dbh});
}


1;