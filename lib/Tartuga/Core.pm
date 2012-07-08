=head1 Tartuga::Core

ядро системы, синхронизирует настройки и загружает модули

=cut

package Tartuga::Core;

use Tartuga::Base;
use Tartuga::Log::Fabric;
use Tartuga::Errors::InitError;

use base "Tartuga::Base";

sub new {
    
    my $class = shift;
    
    my $self = $class->SUPER::new(@_);
    
    $self->{log} = Tartuga::Log::Fabric->create();
    
    $self->init();
    
    return $self;
}

sub init {
    
    my $self = shift;
    
    $self->{log}->debug(__PACKAGE__.' init.');
    
}

sub store {
    
    my $self = shift;
    
    
}

sub loop {
    
}

1;