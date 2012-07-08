=head1 Tartuga::Modules::Base

интерфейс для построения внутреннего модуля ядра системы

=cut

package Tartuga::Modules::Base;

use Tartuga::Base;

use base "Tartuga::Base";

our $VERSION = 0.001;

use Tartuga::Errors::AbstractError;

=item register($core)

хук вызывается во время регистрации модуля в ядре

=cut

sub register {
    
    my $self = shift;
    
    die new Tartuga::Errors::AbstractError("you must override hook register in you module $self");
}


=item process(\$data)

хук вызывается ядром при циклическом обходе
необходимо отдавать ссылку на объекты результатов по входным данным

=cut

sub process {
    
    my $self = shift;
    
    warn new Tartuga::Errors::AbstractError("you must override hook process in you module $self");
    
    return shift;
}