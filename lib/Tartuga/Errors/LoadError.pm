=head1 Tartuga::Errors::InitError

ошибки при инициализации

=cut

package Tartuga::Errors::LoadError;

use strict;
use warnings;
use Tartuga::Exception;

use base "Tartuga::Exception";

our $VERSION = 0.001;

sub alert {
    shift->{logh}->error(shift @_);
}

1;
