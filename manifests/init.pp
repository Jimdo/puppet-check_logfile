define check_logfile (
  tag = undef,
  logfile = undef,
  criticalpatterns = undef,
  criticalexceptions = undef,
  warningpatterns = undef,
  warningexceptions = undef,
  okpatterns = undef,
  options = undef,
  rotation = undef,
  type = undef,
  logfilenocry = undef,
) {

  if ! is_hash($options) {
    fail("options must be a hash: '${options}'")
  }

  if ! ("$logfilenocry" in [ 'true', 'false', '' ] ) {
    fail("logfilenocry is not a boolean or undef: '${logfilenocry}'")
  }

  concat::fragment { "check_logfile_${title}":
    target => 'check_logfile',
    content => template('check_logfile/check_logfile_fragment.erb'),
    order => 10,
  }

}
