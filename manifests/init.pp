# # Class: openfire
#
# Main class for openfire module
# Simplest usage is just by `include openfire`
#
# ## Parameters
#
# ### service_manage
# - default: true
# - options: true, false
# If set to true (default), module will ensure openfire service is enabled
# and running.
#
# ### service_enable
# - default: true
# - options: true, false, manual
# What the module passes to openfire service:enable.
#
# ### service_ensure
# - default: present
# - options: present, false (running, stopped)
# What the module passes to openfire service:ensure.
#
# ### install_glibc
# - default: true
# - options: true, false
# Whether the module should try to install glibc, which is needed by
# bundled java jre version.
#
# ### install_java
# - default: true
# - options: true, false
# Whether the module should try to install java, if enabled, Puppetlab's
# java module will have to be installed. Defaults to false, as jre bundled
# within RPM package is prefered. 
#
# ### java_xms
# - default: 256m
# - options: <size>[g|G|m|M|k|K]
# Size of initial memory allocation passed to JVM.
#
# ### java_xmx
# - default: 512m
# - options: <size>[g|G|m|M|k|K]
# Size of maximum memory allocation passed to JVM.
#
# ### java_opts
# - default:
# - options: String
# Any additional options that should be passed to JVM. These will simply
# be appended to command line, so for typical java opt they have to include
# `-X` such as `-XlargePages`.
#
# ### java_home
# - default: 
# - options: absolute path in the filesystem
# Java home directory passed to init script, by default it's empty and
# init script tries to use one bundled with RPM package which is located in 
# `/opt/openfire/jre`.
#
# ### java_keystore
# - default:
# - options: absolute path in the filesystem
# Path to the file containing java keystore, in case you want to use custom
# certificates. Default to ``.
#
# ### package_name
# - default: openfire
# - options: String
# Name of the package to be installed.
#
# ### package_version
# - default: latest
# - options: latest, String
# Version of the package to be installed, defaults to 'latest'.
#
# ### ensure
# - default: present
# - options: present, absent
# If set to absent, module will try to cleanup after itself and removed 
# any resources installed.
# created on the system.
#
# ### home
# - default: /opt/openfire
# - options: absolute path in the filesystem
# Value put into openfire sysconfig, pointing install location.
#
# ### user
# - default: daemon
# - options: String
# User that the JVM should be run as.
#
# ### group
# - default: daemon
# - options: String
# Group that the JVM should be run as.
#
# ### pidfile
# - default: /var/run/openfire.pid
# - options: absolute path in the filesystem
# Path where the pid file should be located.
#
# ### logdir
# - default: /var/log/openfire
# - options: absolute path in the filesystem
# Path to directory where should the log files be stored.
#
# ## Examples:
#
# Simplest usage is just by including the class itself:
# `include openfire`.
#
# For more oprions use parametrised class like:
# ```class {'::openfire':
#   java_ks => '/usr/local/keys/openfire/keystore',
#   java_xms => '128m',
#   java_xmx => '1024m',
#   version => '3.9.1-1'
# }```
#
# ## Authors
#
# Stepan Stipl <stepan@stipl.net>
#
# ## Copyright
#
# Copyright 2014 Stepan Stipl

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
