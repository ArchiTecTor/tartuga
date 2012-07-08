=head1 Tartuga::Store::Base

интерфейс работы с различными хранилищами

=cut

package Tartuga::Store::Base;

use Tartuga::Base;
use Tartuga::Errors::InitError;

use base "Tartuga::Base";

our @REQUIRE = qw();

our $DATABASE = 'tartuga';

sub import {
    
    my $class = shift;
    
    warnings->import;
    strict->import;
    features->import;
    
}

sub init {
    
}

1;