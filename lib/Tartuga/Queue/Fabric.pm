=head1 Tartuga::Queue::Fabric

интерфейс работы c очередями

=cut

package Tartuga::Queue::Fabric;

use Tartuga::Base;
use Tartuga::Errors::InitError;
use Tartuga::Loader;

use base "Tartuga::Base";

our @REQUIRE = qw(type size);

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
    
    die( new Tartuga::Errors::InitError("queue type field must be one of [@Tartuga::Queue::MODULES]", $self) ) unless( grep($_ eq $type, @Tartuga::Queue::MODULES));
    
    $self->{queue} = "Tartuga::Queue::$type"->new(@_);
    $self->{queue}->init();
    
    return $self;
    
}

1;