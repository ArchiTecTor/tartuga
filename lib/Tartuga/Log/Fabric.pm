=head1 Tartuga::Store::Base

интерфейс работы с различными хранилищами

=cut

package Tartuga::Log::Fabric;

use Tartuga::Base;
use Tartuga::Errors::InitError;
use Tartuga::Loader;

use base "Tartuga::Base";

our @REQUIRE = qw();

our $VERSION = 0.001;

sub import {
    
    my $class = shift;
    
    warnings->import;
    strict->import;
    features->import;
    init();    
}


sub create {
    
    my $class = shift;
    
    my $self = $class->SUPER::new(@_);
    
    die( "log init error, load modules to log is empty [@Tartuga::Log::MODULES]" ) unless( @Tartuga::Log::MODULES);
    
    for my $type (@Tartuga::Log::MODULES) {
        push @{$self->{log_handles}}, "Tartuga::Log::$type"->new(@_);
        $self->{log_handles}[-1]->init();
    }
    
    return $self;
    
}

sub send_all {
    
    my $self = shift;
    
    my $level = shift;
    
    my $count = scalar @{$self->{log_handles}};
    
    my $i = 0;
    for (@{$self->{log_handles}}) {
        $i += $_->send($level,@_);
    }
    
    return $count == $i;
}

sub init {
    
    no strict "refs";
    
    for my $type (qw(debug info warning error fatal)) {
        *{"Tartuga::Log::Fabric::${type}"} = sub {
            
            my $self=shift;
    
            return $self->send_all($type,@_);
        }
    }
}


1;