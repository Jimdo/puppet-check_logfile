class check_logfile::package {

  package { 'check-logfiles':
    ensure => installed
  }

  concat { 'check_logfile':
    path  => '/etc/check_logfile',
    owner => root,
    group => root,
    mode  => 644,
  }

  concat::fragment { 'check_logfile_header':
    target  => 'check_logfile',
    content => '@searches = (',
    order   => 01,
  }

  concat::fragment { 'check_logfile_footer':
    target  => 'check_logfile',
    content => ');',
    order   => 99,
  }
}
