=head1 Tartuga::Queue::Base

интерфейс для построения внутреннего модуля ядра системы

=cut

package Tartuga::Queue::Memory;

use Tartuga::Queue::Base;

use base "Tartuga::Queue::Base";

our $VERSION = 0.001;

our @REQUIRE = qw(size);

use Tartuga::Errors::AbstractError;
use Tartuga::Log::Fabric;



=item init()

хук вызывается во время инициализации

=cut

sub init {
    
    my $self = shift;
    
    # инициализируем пустую очередь
    $self->{queue} = [];
    $self->{log} = Tartuga::Log::Fabric->create();
}


=item push(\@tasks)

кладем данные в очередь, передавать в виде ссылки на массив

в ответе отдает кол-во элементов которое удалось добавить

=cut

sub push {
    
    my $self = shift;
    
    my $tasks = shift;
    
    my $max = $self->{size} - scalar(@{$self->{queue}});
    
    my $count = scalar @$tasks;
    
    unless ($max) {
        $self->{exception} = new Tartuga::Errors::QueueFull('queue is full, push rejected.',$self);
        return 0;
    }
    
    my $i = 0;
    
    for ( ;$i < $max; $i++ ) {
        
        if( $i >= $count ) {
            last;
        }
        push @{$self->{queue}}, $tasks->[$i];
    }
    
    if( $max < $count ) {
        $self->{exception} = new Tartuga::Errors::QueueFull('queue is full, rejected '.($count - $max).' tasks',$self);
    }
    
    return $i + 1;
    
}


=item pop($num)

вернет данные из очереди, в кол-ве переданном в параметре или меньше но не больше

=cut

sub pop {
    
    my $self = shift;
    
    
    
}