=head1 Tartuga::Exception

генерация различных исключений и ошибок

=cut

package Tartuga::Exception;

use strict;
use warnings;

use overload qw("") =>  \&to_string;

use Tartuga::Log::Fabric;

=item new(@params)

создаем объект исключения
на вход передавать 1 или несколько сообщений,
если сообщение является ссылкой то будет произведена
попытка раздампить его

=cut

our $VERSION = 0.01;

sub new {
    
    my $exception_class = shift;
    
    my @caller_info = caller();
    
    for( my $i=0; $i < @_; $i++) {
        if( ref($_[$i]) ) {
            $_[$i] = Data::Dumper->Dump([$_[$i]],[ref($_[$i])]);
        }
    }
    
    my $params = {
        caller  =>  \@caller_info,
        message =>  $exception_class->message(\@caller_info,\@_),
        logh    =>  Tartuga::Log::Fabric->create(),
    };
    
    my $self = bless ($params, $exception_class);
    $self->alert( $params->{message} );
    
    return $self;
    
}

=item alert($message)

перегружаемый метод, устанавливает в каким уровнем нужно отсылать сообщение в логи

=cut

sub alert {
    
    shift->{logh}->fatal(shift @_);
    
}

=item message(\@head,\@data)

генерирует сообщение для логирования

@param \@head ссылка на данные для заголовка

@param \@data ссылка на сами сообщения

=cut

sub message {
    
    my $class = shift;
    
    my $head = shift;
    
    my $data = shift;
    
    return <<"DATA";
[$class][caller: @{$head}]
MESSAGE:
@{[join("\n",@{$data})]}
END
DATA
    
}

sub to_string {
    my $self = shift;
    return $self->{message};
}

1;