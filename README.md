puppet-openfire
===============

Puppet module for installing and configuring Openfire jabber server

Simplest usage:
`include openfire`

See manifests/params.pp for more configuration details.

Requirements
------------
- Tested on RHEL/CentOS 6

Setup
-----
This module will install openfire, using system package manager. It's tested and expected to work with RHEL/CentOS 6, yum package manger and official RPM package from http://www.igniterealtime.org/. Module will also try to install javam, if '$install_java' is enabled (default is disabled, as there's java bundled within the RPM package) and also glibc, as it's needed by the bundled java version. See below list of parameters for available options.

Usage
-----
- Make sure you have puppetlabs stdlib module installed.
- Make sure you have puppetlabs java module installed, if you set `$install_java` to true.
- Make sure there's openfire package (RPM) present in your system repositories
*Currently the module does not support direct download of packages, please open a ticket if you woule be interested in that feature.*
- Simple use is just by including the class by `include openfire` in your manifest, for more options use parametrised class and see available options below.
```
class {'::openfire':
  java_ks => '/usr/local/keys/openfire/keystore',
  java_xms => '128m',
  java_xmx => '1024m',
  version => '3.9.1-1'
}
```

Reference
---------
### Class: openfire
Main class for openfire module
Simplest usage is just by `include openfire`
#### Parameters
##### service_manage
- default: true
- options: true, false
If set to true (default), module will ensure openfire service is enabled
and running.
##### service_enable
- default: true
- options: true, false, manual
What the module passes to openfire service:enable.
##### service_ensure
- default: present
- options: present, false (running, stopped)
What the module passes to openfire service:ensure.
##### install_glibc
- default: true
- options: true, false
Whether the module should try to install glibc, which is needed by
bundled java jre version.
##### install_java
- default: true
- options: true, false
Whether the module should try to install java, if enabled, Puppetlab's
java module will have to be installed. Defaults to false, as jre bundled
within RPM package is prefered. 
##### java_xms
- default: 256m
- options: <size>[g|G|m|M|k|K]
Size of initial memory allocation passed to JVM.
##### java_xmx
- default: 512m
- options: <size>[g|G|m|M|k|K]
Size of maximum memory allocation passed to JVM.
##### java_opts
- default:
- options: String
Any additional options that should be passed to JVM. These will simply
be appended to command line, so for typical java opt they have to include
`-X` such as `-XlargePages`.
##### java_home
- default: 
- options: absolute path in the filesystem
Java home directory passed to init script, by default it's empty and
init script tries to use one bundled with RPM package which is located in 
`/opt/openfire/jre`.
##### java_keystore
- default:
- options: absolute path in the filesystem
Path to the file containing java keystore, in case you want to use custom
certificates. Default to ``.
##### package_name
- default: openfire
- options: String
Name of the package to be installed.
##### package_version
- default: latest
- options: latest, String
Version of the package to be installed, defaults to 'latest'.
##### ensure
- default: present
- options: present, absent
If set to absent, module will try to cleanup after itself and removed 
any resources installed.
created on the system.
##### home
- default: /opt/openfire
- options: absolute path in the filesystem
Value put into openfire sysconfig, pointing install location.
##### user
- default: daemon
- options: String
User that the JVM should be run as.
##### group
- default: daemon
- options: String
Group that the JVM should be run as.
##### pidfile
- default: /var/run/openfire.pid
- options: absolute path in the filesystem
Path where the pid file should be located.
##### logdir
- default: /var/log/openfire
- options: absolute path in the filesystem
Path to directory where should the log files be stored.
#### Examples:
Simplest usage is just by including the class itself:
`include openfire`.
For more oprions use parametrised class like:
```class {'::openfire':
  java_ks => '/usr/local/keys/openfire/keystore',
  java_xms => '128m',
  java_xmx => '1024m',
  version => '3.9.1-1'
}```


Limitations
-----------
- This module has never been tested, and is not really expected to work, on other systems than RHEL/CentOS 6 family
- This module expects openfire package to be present in system pcakage management tool (yum)

FAQ, Support & Development
--------------------------
Feek free to fork the module and extend it in any way, any pull requests will be welcome. Also let me know in case you're interested in some functionality.
Please use Github's Issues for any communication & bug reporting.

TODO
----
- better passing of args to java class
- proper modulefile & release to Puppet Forge
- tests
