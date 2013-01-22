class packages {

  $solr_packages = [
    'java-1.6.0-openjdk',
    #'java-1.6.0-openjdk-devel',
  ]

  package { $solr_packages:
    ensure => installed,
  }

}
