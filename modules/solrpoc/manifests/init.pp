class solrpoc {

#  file { '/usr/local/dvn/sbin' :
#    ensure  => directory,
#    require => File['/usr/local/dvn'],
#  }
#
#  file { '/usr/local/dvn' :
#    ensure  => directory,
#  }

  file { '/etc/sysconfig/iptables':
    source => 'puppet:///modules/solrpoc/etc/sysconfig/iptables',
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

}
