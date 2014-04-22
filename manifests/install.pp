# == Class: openfire::install
#
# This installs Openfire packages
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

class openfire::install inherits openfire {

  if $install_java == true {
    class{'java':
      before => Package['openfire']
    }
  }

  if $install_glibc == true {
    package { "glibc.i686":
      ensure => "installed",
      before => Package['openfire']
    }
  }

  package { 'openfire':
    ensure => $my_package_ensure,
    name   => $package_name,
  } ->

  file { $logdir:
    ensure => directory,
    owner   => $user,
    group  => $group,
    mode   => 0644
  }

}
