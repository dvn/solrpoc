# Solr Proof of Concept

## What is this?

This git repo contains a [Vagrant][] environment for standing up a proof of concept for integrating [Solr][] with a [Dataverse Network][] installation.

[Vagrant]: http://vagrantup.com
[Solr]: http://lucene.apache.org/solr
[Dataverse Network]: http://thedata.org

See also https://redmine.hmdc.harvard.edu/issues/2656

`vagrant up`

"Solritas" interface: http://localhost:8983/solr/collection1/browse

# DVN API

Official DVN API doc is https://sourceforge.net/projects/dvn/files/dvn/3.0/dvnapi_v1_0.pdf via http://guides.thedata.org/book/data-sharing-api

Fields you can search on:

https://dvn.iq.harvard.edu/dvn/api/metadataSearchFields/

Example query for "quantitative":

https://dvn.iq.harvard.edu/dvn/api/metadataSearch/title:quantitative
