# == Class: openfire
#
# Main class for openfire module
# Simplest usage is just by `include openfire`
#
# === Parameters
#
# [*service_manage*]
# True/false. If set to true (default), module will ensure openfire
# service is enabled and running.
#
# [*service_enable*]
# What the module passes to service - enable (defaults to true).
#
# [*service_ensure*]
# What the module passes to service - ensure (defaults to true).
#
# [*install_glibc*]
# Whether the module should try to install glibc, which is needed by
# bundled java jre version (defaults to true).
#
# [*install_java*]
# Whether the module should try to install java, if enabled Puppetlab's
# java module will have to be installed. Defaults to false, as jre bundled
# within RPM package is prefered. 
#
# [*java_xms*]
# Size of initial memory allocation passed to JVM. Defaults to `256m`.
#
# [*java_xmx*]
# Size of maximum memory allocation passed to JVM. Defaults to `512m`.
#
# [*java_opts*]
# Any additional options that should be passed to JVM. Defaults to ``.
#
# [*java_home*]
# Java home directory passed to init script, by default we try to use one
# bundled with RPM package which is located in `/opt/openfire/jre`.
# Defaults to ``.
#
# [*java_keystore*]
# Path to the file containing java keystore, in case you want to use custom
# certificates. Default to ``.
#
# [*package_name*]
# Name of the package to be installed. Defaults to 'openfire'.
#
# [*package_version*]
# Version of the package to be installed, defaults to 'latest'.
#
# [*ensure*]
# Value that will be passed to package ensure (defaults to `present`).
#
# [*home*]
# Vaule put into sysconfig file of openfire install dir.
# Default is '/opt/openfire'.
#
# [*user*]
# User that the JVM should be run as, defaults to `daemon`.
#
# [*group*]
# Group that the JVM should be run as, defaults to `daemon`.
#
# [*pidfile*]
# Path to the pid file. Defaults to '/var/run/openfire.pid'.
#
# [*logdir*]
# Where should the log files be sotred, default is '/var/log/openfire'.
#
# === Examples
# Simplest usage is just by including the class itself `include openfire`,
# 
# For more oprions use parametrised class like:
# class {'::openfire':
#   java_ks => '/usr/local/keys/openfire/keystore',
#   java_xms => '128m',
#   java_xmx => '1024m',
#   version => '3.9.1-1'
# }
#
# === Authors
#
# Stepan Stipl <stepan@stipl.net>
#
# === Copyright
#
# Copyright 2014 Stepan Stipl
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
