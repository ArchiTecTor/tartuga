package Tartuga::Log::File;



use FindBin;
use Tartuga::Log::Base;
use base "Tartuga::Log::Base";

our $VERSION = 0.001;

our $LOG_DIR = "$FindBin::Bin/../log";

# если директории нет то создаст
# если запись в директорию не разрешена - ошибка
# если файл не удается создать или открыть - ошибка

sub send{
    my $self=shift;
    my $level=shift;
    
    unless( -e $LOG_DIR ){
        unless( mkdir($LOG_DIR) ) {
            $self->log_fatal('cannot create log dir $LOG_DIR - $!');
            return 0;
        }
    }
    
    unless( -w $LOG_DIR ) {
        $self->log_fatal('cannot write to log dir $LOG_DIR - $!');
        return 0;
    }
    
    my $result=1;
    
    if($Tartuga::Log::Base::DEBUG){
        if( open my $fh,'>>',$LOG_DIR."/debug.log" ) { 
            print $fh '['.scalar(localtime)."][$level] @_\n";
            close $fh;
        }
        else {
            $self->log_fatal("open file ".$LOG_DIR."/debug.log failed $!");
            $result = 0;
        }
    }
    
    return $result if($level eq "debug");
    
    if( open my $fh,'>>',$LOG_DIR."/$level.log" ) {
        
        print $fh '['.scalar(localtime)."][$level] @_\n";
        close $fh;
    }
    else {
        $self->log_fatal("open file ".$LOG_DIR."/$level.log failed $!");
        return 0;
    }
    
    return $result;
    
}

1;