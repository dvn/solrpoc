#!/bin/sh
#mvn clean && mvn package && java -cp target/solr-search-1.0-SNAPSHOT.jar edu.harvard.iq.pdurbin.solrjsearcher.App
mvn clean compile exec:java
