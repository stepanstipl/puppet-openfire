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

  if $service_manage == true {
    service { 'openfire':
      ensure  => $service_ensure,
      enable  => $service_enable,
      hasstatus => true,
      hasrestart => true,
    }
  }

}
