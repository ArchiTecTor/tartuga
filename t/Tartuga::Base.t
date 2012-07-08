package MyTest;
use Test::More tests => 5;
use strict;
use warnings;
#use diagnostics;

use Try::Tiny;

$Tartuga::Log::DEBUG=1;

use lib "../lib";

use_ok "Tartuga::Base";

use base "Tartuga::Base";

our @REQUIRE = qw(err dddd);

can_ok "Tartuga::Base", qw{new require_params};

ok my $obj = new Tartuga::Base(), "create new object Tartuga::Base";

my $self = try {
    new MyTest(err=>1)
};


is $self, undef, "create new MyTest obj without required params";

ok $self = new MyTest(err=>1, dddd=>1), "create new MyTest with required params";



