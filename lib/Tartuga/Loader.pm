package Tartuga::Loader;

=head1 Tartuga::Loader

автозагрузчик модулей

=cut

use strict;
use warnings;

use Tartuga::Errors::InitError;
use Tartuga::Errors::LoadError;

use Tartuga::Log::Fabric;

our $VERSION = 0.001;

=item import

подгружаем в namespace вызвавшего модуля пакеты которые найдем в каталоге (как правило используется для Fabric классов)

=cut

sub import {
    
    my $class = (caller())[0];
    
    my ($dir) = $class =~ m|^(.+?)::\w+$|;
    
    my $namespace = $dir;
    
    $dir =~ s|::|/|;
    
    
    
    no strict 'refs';
    
    
    for my $path ( @INC ) {
        if (-e "$path/$dir") {
            
            opendir my $dirh, "$path/$dir" or die( new Tartuga::Errors::InitError("can't open store lib dir for reading $path/$dir") );
            
            for my $file (readdir $dirh) {
                next if($file eq "Base.pm" || $file eq "Fabric.pm");
                
                if($file =~ m/(\w+).pm/i) {
                    
                    unless( eval "require ${namespace}::$1" ) {
                        new Tartuga::Errors::LoadError("failed load store module ${namespace}::$1",$@);
                    }
                    else {
    
                        push @{"${namespace}::MODULES"}, $1;
                    }
                }
            }
            close $dirh;
        }
    }
}

1;