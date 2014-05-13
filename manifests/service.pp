# == Class: openfire::service
#
# This manages Openfire service
# See main Openfire class for docs.
#
# === Authors
#
# Stepan Stipl <stepan@stipl.net>
#
# === Copyright
#
# Copyright 2014 Stepan Stipl
#

class openfire::service inherits openfire {

  if $openfire::service_manage == true {
    service { 'openfire':
      ensure     => $openfire::service_ensure,
      enable     => $openfire::service_enable,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
