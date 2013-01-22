#!/usr/bin/env perl
use strict;
use warnings;
use v5.10;
use Readonly;
use XML::Simple;
use LWP::Simple;
use Data::Dumper;
binmode STDOUT, ':encoding(utf8)';

Readonly my $api_url => 'https://dvn.iq.harvard.edu/dvn/api';
Readonly my $titlesearch_url => "$api_url/metadataSearch/title:quantitative";

my $titlesearch_xml = get($titlesearch_url);
my $titlesearch_dd  = XMLin($titlesearch_xml);

my $doc_add_xml = "<add>\n";
my $hashref;

while ( my $study = shift @{ $titlesearch_dd->{searchHits}{study} } ) {
    next if $study->{ID} eq 'hdl:1902.1/15263';
    next if $study->{ID} eq 'hdl:1902.1/16573';
    #https://dvn.iq.harvard.edu/dvn/api/metadata/hdl:1902.1/SZKONDGOMF
    my $metadata_url = "https://dvn.iq.harvard.edu/dvn/api/metadata/$study->{ID}";
    my $metadata_xml = get($metadata_url);
    my $metadata_dd = XMLin($metadata_xml);
    my $abstract = $metadata_dd->{stdyDscr}{stdyInfo}{abstract};
    my $title = $metadata_dd->{stdyDscr}{citation}{titlStmt}{titl};
    my $date = $metadata_dd->{stdyDscr}{citation}{distStmt}{distDate}{date};
    $date = $date ? $date : 'N/A';
    ($date) = $date =~ /^(\d\d\d\d)/;
    my $hashref = {
        field => [
            { name => 'id',    content => $study->{ID} },
            { name => 'title', content => $title },
            { name => 'cat',   content => $date },
        ]
    };
    my $doc_xml = XMLout( $hashref, RootName => 'doc' );
    $doc_add_xml .= "\n$doc_xml\n";
}

$doc_add_xml .= "</add>\n";
say $doc_add_xml;
