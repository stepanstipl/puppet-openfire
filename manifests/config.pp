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
    ensure  => present,
    content => template('openfire/sysconfig.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  if ($openfire::java_ks != '') {
    file { "${openfire::home}/resources/security/keystore":
      ensure => $openfire::java_ks,
    }
  }

}
