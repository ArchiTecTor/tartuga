=head1 Tartuga::Log

класс для логирования событий различных категорий проекта

=cut

package Tartuga::Log;

use strict;
use warnings;
use FindBin;
use Sys::Syslog;
use Data::Dumper;

our $VERSION = 0.01;

our $LOG_DIR = "$FindBin::Bin/../log";

our $DEBUG = 0;


$|=1;

sub new {
    
    my $class = shift;
    
    my $params = {@_};
    
    return bless $params, $class;
    
}



sub log_fatal{
    
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

sub writeToLog{
    my $self=shift;
    my $level=shift;
    
    unless( -e $LOG_DIR ){
        unless( mkdir($LOG_DIR) ) {
            $self->log_fatal('cannot create log dir $LOG_DIR - $!');
            return 1;
        }
    }
    
    unless( -w $LOG_DIR ) {
        $self->log_fatal('cannot write to log dir $LOG_DIR - $!');
        return 1;
    }
    
    my $result=0;
    
    if($DEBUG){
        if( open my $fh,'>>',$LOG_DIR."/debug.log" ) { 
            print $fh '['.scalar(localtime)."][$level] @_\n";
            close $fh;
        }
        else {
            $self->log_fatal("open file ".$LOG_DIR."/debug.log failed $!");
            $result = 1;
        }
    }
    
    return $result if($level eq "debug");
    
    if( open my $fh,'>>',$LOG_DIR."/$level.log" ) {
        
        print $fh '['.scalar(localtime)."][$level] @_\n";
        close $fh;
    }
    else {
        $self->log_fatal("open file ".$LOG_DIR."/$level.log failed $!");
        return 1;
    }
    
    return $result;
}


# Группа для логирования событий
# каждый метод может дополнительно дублировать информацию в debug

# обычный информационный лог
sub info
{
    my $self=shift;
    $self->writeToLog('info',@_);
}

# предупреждения и т.п.
sub warning
{
    my $self=shift;
    $self->writeToLog('warning',@_);
}

# синоним warning
sub warn
{
    shift->warning(@_);
}

# лог ошибок и критических ошибок
sub error
{
    my $self=shift;
    $self->writeToLog('error',@_);
}

# совсем фатальные ошибки, программа должна по логике завершиться
sub fatal{
    my $self=shift;
    $self->writeToLog('fatal',@_);
}

# логирование отладочной информации
sub debug
{
    my $self=shift;
    $self->writeToLog('debug',@_);

}

1;
