# == Class: openfire::params
#
# Default parameters for Openfire class
# See main Openfire class for docs
#
# === Authors
#
# Stepan Stipl <stepan@stipl.net>
#
# === Copyright
#
# Copyright 2014 Stepan Stipl
#

class openfire::params {

  $service_manage  = true
  $service_enable  = true
  $service_running = true
  $service_ensure  = true

  $install_glibc   = true
  $install_java    = false
  $java_xms        = '256m'
  $java_xmx        = '512m'
  $java_opts       = ''
  $java_home       = ''
  $java_keystore   = ''

  $package_name    = 'openfire'
  $package_version = 'latest'
  $ensure          = 'present'

  $home            = '/opt/openfire'
  $user            = 'daemon'
  $group           = 'daemon'
  $pidfile         = '/var/run/openfire.pid'
  $logdir          = '/var/log/openfire'

}
