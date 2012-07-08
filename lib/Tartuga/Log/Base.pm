=head1 Tartuga::Log

класс для логирования событий различных категорий проекта

=cut

package Tartuga::Log::Base;

use strict;
use warnings;
use FindBin;
use Sys::Syslog;

use Tartuga::Base;
use base "Tartuga::Base";

our $VERSION = 0.01;


our $DEBUG = 0;


$|=1;




sub log_fatal {
    
    my $self=shift;
    my $message=shift;
    
    openlog($self->{folder}, "ndelay,pid", "local0");
    syslog('info|local0',$message);
    closelog();
    $self->{fatal}($message);
    
}


# если директории нет то создаст
# если запись в директорию не разрешена - ошибка
# если файл не удается создать или открыть - ошибка

sub send {
    my $self=shift;
    my $level=shift;
    
    
    my $result=0;
    
    if($DEBUG){
        print STDOUT '['.scalar(localtime)."][$level] @_\n";   
    }
    
    return $result if($level eq "debug");
    
        
    print STDOUT '['.scalar(localtime)."][$level] @_\n";
    
    return $result;
}

sub init {
    
}


1;
