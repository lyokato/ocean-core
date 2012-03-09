package Ocean::Stanza::DeliveryRequest::SASLAuthCompletion;

use strict;
use warnings;

use parent 'Class::Accessor::Fast';

__PACKAGE__->mk_accessors(qw(
    stream_id    
    user_id
    username
    session_id
));

1;
