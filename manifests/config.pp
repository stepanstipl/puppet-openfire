# == Class: openfire::config
#
# This configures Openfire
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

class openfire::config inherits openfire {

  file { '/etc/sysconfig/openfire':
    ensure => present,
    content => template("openfire/sysconfig.erb"),
    owner => "root",
    group => "root",
    mode => "644",
  }

  if ($java_ks != '') {
    file { "${home}/resources/security/keystore":
      ensure => $java_ks,
    }
  }

}
