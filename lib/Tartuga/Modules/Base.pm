=head1 Tartuga::Modules::Base

интерфейс для построения внутреннего модуля ядра системы

=cut

package Tartuga::Modules::Base;

use Tartuga::Base; 

use base "Tartuga::Base";

our $VERSION = 0.001;

our @REQUIRE = qw(queue_size queue_store_type);

use Tartuga::Queue::Fabric;
use Tartuga::Errors::AbstractError;


sub new {
    
    my $self = shift->SUPER::new(@_);
    
    # создаем fifo очередь для модуля которая может содержать не больше queue_size
    # задач в оперативной памяти, остальное будет смещаться в хранилище  
    $self->{queue} = Tartuga::Queue::Fabric->create(
        size => $self->{queue_size},
        type => $self->{queue_store_type},
    );
    
    return $self;
}

=item register($core)

хук вызывается во время регистрации модуля в ядре

=cut

sub register {
    
    my $self = shift;
    
    die new Tartuga::Errors::AbstractError("you must override hook register in you module $self");
}

=item push

кладем задачу для модуля в его очередь

=cut

sub push {
    
    my $self = shift;
    
    # переданные задачи в очередь приема
    my @tasks = @_;
    
    
    
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