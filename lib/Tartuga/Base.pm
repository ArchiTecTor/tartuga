# базовый класс инкапсулирующий общие методы и данные
package Tartuga::Base;
use strict;
use warnings;

our $VERSION = 0.001;

use Data::Dumper;
use Tartuga::Errors::InitError;

use overload qw("") =>  \&as_string;

our @REQUIRE = qw();

use Tartuga::Log;

=item new(?params)

@params array, arrayref or hashref

конструктор, параметры переданные на вход кладутся в хеш
объекта, созданного впоследствии

=cut

sub new {
    
    my $class = shift;
    
    $class->require_params({@_});
    
    my $params = {
        class => $class,
        @_,
    };
    
    return bless $params, $class;
}

sub import {
    
    my $class = shift;
    
    no strict 'refs';
    
    *{"${class}::REQUIRE"} = *Tartuga::Base::REQUIRE unless(scalar *{"${class}::REQUIRE"});
    strict->import;
    warnings->import;
    feature->import;
}

sub require_params {
    
    my $class = shift;
    
    my $params = shift;
    
    no strict 'refs';
    
    my $require = *{"${class}::REQUIRE"};
    
    # проверяем существование каждого обязательного ключа
    # в переданных данных
    for my $field ( @$require ) {
        if( !exists($params->{$field}) ) {
            # обязательного параметра в хеше нет,
            # вызываем исключение
            die( new Tartuga::Errors::InitError("class $class, required param '$field' not be found",$params));
        }
        
        
    }
}

sub log {
    
    my $self = shift;
    
    
}

sub as_string {
    
    my $self = shift;
    
    return Data::Dumper->Dump([$self],[ref $self]);
}

sub DESTROY {
    my $self = shift;
}

1;