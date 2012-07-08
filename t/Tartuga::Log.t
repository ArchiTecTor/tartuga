use Test::More tests => 5;
use strict;
use warnings;
#use diagnostics;

use Try::Tiny;


use lib "../lib";

use Tartuga::Log::Base;
$Tartuga::Log::Base::DEBUG=1;

use_ok "Tartuga::Log::Fabric";


can_ok "Tartuga::Log::Fabric", qw{new require_params info error warning warn fatal};

ok my $obj = Tartuga::Log::Fabric->create(), "create new object Tartuga::Log::Fabric";

ok $obj->debug('test'), "send debug";
ok $obj->info('test'), "send info";
ok $obj->warning('test'), "send warning";
ok $obj->error('test'), "send error";
ok $obj->fatal('test'), "send fatal";


