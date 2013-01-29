package edu.harvard.iq.pdurbin.solrjsearcher;

import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.CommonsHttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.params.ModifiableSolrParams;
import java.net.MalformedURLException;

public class App 
{

	public static void main(String[] args) throws MalformedURLException, SolrServerException {
		System.out.println( "Searching Solr on localhost... (assuming it's running)" );
		CommonsHttpSolrServer solr = new CommonsHttpSolrServer("http://localhost:8983/solr");

		ModifiableSolrParams params = new ModifiableSolrParams();
		//params.set("q", "cat:electronics");
		params.set("q", "*:*");
		params.set("defType", "edismax");
		params.set("start", "0");

		QueryResponse response = solr.query(params);
		SolrDocumentList results = response.getResults();
		for (int i = 0; i < results.size(); ++i) {
			System.out.println(results.get(i));
		}

	}

}
