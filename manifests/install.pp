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

  if $openfire::install_java == true {
    class{'java':
      before => Package['openfire']
    }
  }

  if $openfire::install_glibc == true {
    package { 'glibc.i686':
      ensure => installed,
      before => Package['openfire']
    }
  }

  package { 'openfire':
    ensure => $openfire::my_package_ensure,
    name   => $openfire::package_name,
  } ->

  file { $openfire::logdir:
    ensure => directory,
    owner  => $openfire::user,
    group  => $openfire::group,
    mode   => '0644'
  }

}
