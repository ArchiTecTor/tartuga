use Test::More tests => 5;
use strict;
use warnings;
#use diagnostics;

use Try::Tiny;


use lib "../lib";

use_ok "Tartuga::Store::Fabric";

can_ok "Tartuga::Store::Fabric", qw{create require_params new};


ok my $self = Tartuga::Store::Fabric->create(store=>'MySQL', user=>'d', password=>'d'), "create new Tartuga::Store::Fabric engine MySQL";


ok $self = Tartuga::Store::Fabric->create(store=>'PostgreSQL'), "create new Tartuga::Store::Fabric engine PostgreSQL";

