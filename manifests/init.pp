define check_logfile (
  tag = undef,
  logfile = undef,
  criticalpattern = undef,
  warningpattern = undef,
  options = undef,
  rotation = undef,
  type = undef,
) {

  if ! is_hash($options) {
    fail("options must be a hash ${options}") 
  }

  concat::fragment { "check_logfile_${title}":
    target => 'check_logfile',
    content => template('check_logfile/check_logfile_fragment.erb'),
    order => 10,
  }

}
