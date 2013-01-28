#!/usr/bin/perl
use strict;
use warnings;
# http://wiki.apache.org/solr/FAQ#How_can_I_delete_all_documents_from_my_index.3F
`curl -s http://localhost:8983/solr/update --data '<delete><query>*:*</query></delete>' -H 'Content-type:text/xml; charset=utf-8'`;
`curl -s http://localhost:8983/solr/update --data '<commit/>' -H 'Content-type:text/xml; charset=utf-8'`;
