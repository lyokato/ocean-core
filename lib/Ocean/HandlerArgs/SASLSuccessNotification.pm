package Ocean::HandlerArgs::SASLSuccessNotification;

use strict;
use warnings;

use parent 'Class::Accessor::Fast';

__PACKAGE__->mk_accessors(qw(
    stream_id    
    username
));

1;
