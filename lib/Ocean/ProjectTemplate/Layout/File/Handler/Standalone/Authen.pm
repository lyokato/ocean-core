package Ocean::ProjectTemplate::Layout::File::Handler::Standalone::Authen;

use strict;
use warnings;

use parent 'Ocean::ProjectTemplate::Layout::File';

sub template     { do { local $/; <DATA> } }
sub default_name { 'Authen.pm' }

1;
__DATA__
package <: $context.get('handler_class') :>::Authen;

use strict;
use warnings;

use parent 'Ocean::Standalone::Handler::Authen';

=head1 NAME

<: $context.get('handler_class') :>::Authen - Authen Event Handler

=head1 COPYRIGHT AND LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

1;
