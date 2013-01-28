#!/usr/bin/env perl
use strict;
use warnings;
use v5.10;
use Readonly;
use XML::Simple;
use LWP::Simple;
use Data::Dumper;
use DateTime;
binmode STDOUT, ':encoding(utf8)';

Readonly my $api_url => 'https://dvn.iq.harvard.edu/dvn/api';
# https://dvn.iq.harvard.edu/dvn/api/metadataSearchFields
Readonly my $titlesearch_url => "$api_url/metadataSearch/authorName:King";

my $titlesearch_xml = get($titlesearch_url);
my $titlesearch_dd  = XMLin($titlesearch_xml);

my $doc_add_xml = "<add>\n";
my $hashref;

my $count;
while ( my $study = shift @{ $titlesearch_dd->{searchHits}{study} } ) {
    next if $study->{ID} eq 'hdl:1902.1/15263';
    next if $study->{ID} eq 'hdl:1902.1/16573';

    next if $study->{ID} eq 'hdl:1902.1/01996';
    next if $study->{ID} eq 'hdl:1902.1/01964';
    next if $study->{ID} eq 'hdl:1902.1/01978';
    next if $study->{ID} eq 'hdl:1902.1/02012';
    next if $study->{ID} eq 'hdl:1902.1/01967';
    next if $study->{ID} eq 'hdl:1902.1/01977';
    next if $study->{ID} eq 'hdl:1902.1/01979';
    next if $study->{ID} eq 'hdl:1902.1/01970';
    next if $study->{ID} eq 'hdl:1902.1/01989';
    next if $study->{ID} eq 'hdl:1902.1/01980';
    next if $study->{ID} eq 'hdl:1902.1/01993';
    next if $study->{ID} eq 'hdl:1902.1/01960';
    next if $study->{ID} eq 'hdl:1902.1/01992';
    next if $study->{ID} eq 'hdl:1902.1/01994';
    next if $study->{ID} eq 'hdl:1902.1/01963';
    next if $study->{ID} eq 'hdl:1902.1/01966';
    next if $study->{ID} eq 'hdl:1902.1/01976';
    next if $study->{ID} eq 'hdl:1902.1/02008';
    next if $study->{ID} eq 'hdl:1902.1/02009';
    next if $study->{ID} eq 'hdl:1902.1/01969';
    next if $study->{ID} eq 'hdl:1902.1/01997';
    next if $study->{ID} eq 'hdl:1902.1/01972';
    next if $study->{ID} eq 'hdl:1902.1/02010';
    next if $study->{ID} eq 'hdl:1902.1/01956';
    next if $study->{ID} eq 'hdl:1902.1/02007';
    next if $study->{ID} eq 'hdl:1902.1/01998';
    next if $study->{ID} eq 'hdl:1902.1/01962';
    next if $study->{ID} eq 'hdl:1902.1/01975';
    last if $study->{ID} eq 'hdl:1902.1/01995';
    #last if $study->{ID} eq 'hdl:1902.1/01989';
    #say $study->{ID};
    #https://dvn.iq.harvard.edu/dvn/api/metadata/hdl:1902.1/SZKONDGOMF
    my $metadata_url = "https://dvn.iq.harvard.edu/dvn/api/metadata/$study->{ID}";
    my $metadata_xml = get($metadata_url);
    my $metadata_dd  = XMLin($metadata_xml);
    #print Dumper $metadata_dd;
    my $abstract = $metadata_dd->{stdyDscr}{stdyInfo}{abstract};
    my $title    = $metadata_dd->{stdyDscr}{citation}{titlStmt}{titl};
    #my $date = $metadata_dd->{stdyDscr}{citation}{distStmt}{distDate}{date};
    my $date = $metadata_dd->{stdyDscr}{citation}{prodStmt}{prodDate}{date};
    #say $study->{ID};
    next if ref $metadata_dd->{stdyDscr}{citation}{rspStmt}{AuthEnty} ne 'ARRAY';
    #say ref $metadata_dd->{stdyDscr}{citation}{rspStmt}{AuthEnty}[0];
    next if ref $metadata_dd->{stdyDscr}{citation}{rspStmt}{AuthEnty}[0] ne 'HASH';
    #print Dumper $metadata_dd->{stdyDscr}{citation}{rspStmt}{AuthEnty};
    #say $count++;
    #my $author;
    my $author = $metadata_dd->{stdyDscr}{citation}{rspStmt}{AuthEnty}[0]{content};
    #next;
    #say $author;
    $date = $date ? $date : 'N/A';
    ($date) = $date =~ /^(\d\d\d\d)/;
    my $dt = DateTime->new( year => $date );
# 'The trailing "Z" designates UTC time and is mandatory' -- http://lucene.apache.org/solr/4_1_0/solr-core/org/apache/solr/schema/DateField.html
    my $iso8601 = $dt->iso8601() . 'Z';
    my $hashref = {
        field => [
            { name => 'id',                 content => $study->{ID} },
            { name => 'title',              content => $title },
            { name => 'manufacturedate_dt', content => $iso8601 },
            { name => 'author',             content => $author },
        ]
    };
    my $doc_xml = XMLout( $hashref, RootName => 'doc' );
    $doc_add_xml .= "\n$doc_xml\n";
}

$doc_add_xml .= "</add>\n";
say $doc_add_xml;
