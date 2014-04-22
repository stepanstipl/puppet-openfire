# == Class: openfire
#
# Full description of class openfire here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { openfire:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class openfire (
  $ensure          = $openfire::params::ensure,
  $home            = $openfire::params::home,
  $install_glibc   = $openfire::params::install_glibc,
  $install_java    = $openfire::params::install_java,
  $java_xms        = $openfire::params::java_xms,
  $java_xmx        = $openfire::params::java_xmx,
  $java_opts       = $openfire::params::java_opts,
  $java_home       = $openfire::params::java_home,
  $java_ks         = $openfire::params::java_ks,
  $logdir          = $openfire::params::logdir,
  $package_name    = $openfire::params::package_name,
  $package_version = $openfire::params::package_version,
  $package_ensure  = $openfire::params::package_ensure,
  $pidfile         = $openfire::params::pidfile,
  $service_manage  = $openfire::params::service_manage,
  $service_enable  = $openfire::params::service_enable,
  $service_ensure  = $openfire::params::service_ensure,
  $user            = $openfire::params::user,
  $group            = $openfire::params::group,
  
) inherits openfire::params {
  
  validate_bool($service_manage)
  validate_bool($service_enable)
  validate_bool($install_java)

  $my_package_ensure = $ensure ? {
    'present' => $package_version,
    default => absent
  }

  $my_java_opts = "-Xmx${java_xmx} -Xms${java_xms} ${java_opts}"

  anchor {'openfire::begin': }  ->
  class {'openfire::install': } ->
  class {'openfire::config': }  ->
  class {'openfire::service': } ->
  anchor {'openfire::end': }

}
