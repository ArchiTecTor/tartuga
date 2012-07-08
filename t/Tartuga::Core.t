use Test::More tests => 5;
use strict;
use warnings;
#use diagnostics;

use Try::Tiny;


use lib "../lib";

use Tartuga::Log::Base;

$Tartuga::Log::Base::DEBUG=1;

use_ok "Tartuga::Core";

can_ok "Tartuga::Core", qw{new require_params store loop};

ok my $self = new Tartuga::Core(), "create new Tartuga::Core";
