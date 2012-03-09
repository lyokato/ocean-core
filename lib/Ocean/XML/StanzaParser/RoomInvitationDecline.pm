package Ocean::XML::StanzaParser::RoomInvitationDecline;

use strict;
use warnings;

use parent 'Ocean::XML::StanzaParser';

use Ocean::Error;
use Ocean::JID;
use Ocean::Config;
use Ocean::Constants::MessageType;
use Ocean::Constants::StanzaErrorCondition;
use Ocean::Constants::StanzaErrorType;
use Ocean::Util::XML qw(unescape_xml_char);
use Ocean::XML::Namespaces qw(MUC_USER);

use Ocean::Stanza::Incoming::RoomInvitationDecline;

sub parse {
    my ($class, $element) = @_;

    my $to = $element->attr('to');

    Ocean::Error::MessageError->throw(
        type      => Ocean::Constants::StanzaErrorType::CANCEL,
        condition => Ocean::Constants::StanzaErrorCondition::BAD_REQUEST,
        message   => q{message@to not found},
    ) unless $to;

    # XXX accept messages which 'to' is not user?
    my $to_jid = Ocean::JID->new($to);

    Ocean::Error::MessageError->throw(
        type      => Ocean::Constants::StanzaErrorType::CANCEL,
        condition => Ocean::Constants::StanzaErrorCondition::JID_MALFORMED,
        message   => sprintf(q{invalid jid, "%s"}, $to)
    ) unless $to_jid;

    my $domain = $to_jid->domain;

    my $config = Ocean::Config->instance;
    return unless (   
           $domain 
        && $config->has_section('muc')
        && $config->get(muc => 'domain') eq $domain);

    my $room = $to_jid->node;
    return unless $room;

    my $x = $element->get_first_element_ns(MUC_USER, 'x');
    return unless $x;

    my $decline = $x->get_first_element('decline');
    return unless $decline;

    my $decline_to = $decline->attr('to');
    my $decline_to_jid = Ocean::JID->new($decline_to);
    return unless $decline_to_jid;
    my $user = $decline_to_jid->node;
    return unless $user;

    my $reason_elem = $decline->get_first_element('reason');
    my $reason = $reason_elem ? $reason_elem->text : '';

    my $continue_elem = $decline->get_first_element('continue');
    my $thread = ($continue_elem && $continue_elem->attr('thread'))
        ? $continue_elem->attr('thread') : undef;

    return Ocean::Stanza::Incoming::RoomInvitationDecline->new(
        $room, $decline_to_jid, $reason, $thread);
}

1;
