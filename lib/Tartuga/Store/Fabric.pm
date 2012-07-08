=head1 Tartuga::Store::Base

интерфейс работы с различными хранилищами

=cut

package Tartuga::Store::Fabric;

use Tartuga::Base;
use Tartuga::Errors::InitError;
use Tartuga::Loader;

use base "Tartuga::Base";

our @REQUIRE = qw(store);

our $VERSION = 0.001;

sub import {
    
    my $class = shift;
    
    warnings->import;
    strict->import;
    features->import;
    
}


sub create {
    
    my $class = shift;
    
    my $self = $class->SUPER::new(@_);
    
    my $type = $self->{store};
    
    die( new Tartuga::Errors::InitError("store field must be one of [@Tartuga::Store::MODULES]", $self)) unless( grep($_ eq $type, @Tartuga::Store::MODULES));
    
    $self->{store_handle} = "Tartuga::Store::$type"->new(@_);
    $self->{store_handle}->init();
    
    return $self;
    
}

1;