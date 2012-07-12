=head1 Tartuga::Queue::Base

интерфейс для построения внутреннего модуля ядра системы

=cut

package Tartuga::Queue::Base;

use Tartuga::Base;

use base "Tartuga::Base";

our $VERSION = 0.001;

our @REQUIRE = qw();

use Tartuga::Errors::AbstractError;



=item init()

хук вызывается во время инициализации

=cut

sub init {
    
    my $self = shift;
    
    die new Tartuga::Errors::AbstractError("you must override hook init in you module $self");
}

=item push(\@tasks)

кладем данные в очередь, передавать в виде ссылки на массив

=cut

sub push {
    
    my $self = shift;
    
    die new Tartuga::Errors::AbstractError("you must override hook push in you module $self");
    
}


=item pop($num)

вернет данные из очереди, в кол-ве переданном в параметре или меньше но не больше

=cut

sub pop {
    
    my $self = shift;
    
    die new Tartuga::Errors::AbstractError("you must override hook process in you module $self");
    
}