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

### Parameters

####`service_manage`

If set to 'true ' (default), module will ensure openfire
service is enabled and running.

####`service_enable`

What the module passes to service - enable (defaults to true).

####`service_ensure`

What the module passes to service - ensure (defaults to true).

####`install_glibc`

Whether the module should try to install glibc, which is needed by
bundled java jre version (defaults to true).

####`install_java`

Whether the module should try to install java, if enabled Puppetlab's
java module will have to be installed. Defaults to false, as jre bundled
within RPM package is prefered.

####`java_xms`

Size of initial memory allocation passed to JVM. Defaults to `256m`.

####`java_xmx`

Size of maximum memory allocation passed to JVM. Defaults to `512m`.

####`java_opts`

Any additional options that should be passed to JVM. Defaults to ``.

####`java_home`

Java home directory passed to init script, by default we try to use one
bundled with RPM package which is located in `/opt/openfire/jre`.
Defaults to ``.

####`java_keystore`

Path to the file containing java keystore, in case you want to use custom
certificates. Default to ``.

####`package_name`

Name of the package to be installed. Defaults to 'openfire'.

####`package_version`

Version of the package to be installed, defaults to 'latest'.

####`ensure`

Value that will be passed to package ensure (defaults to `present`).

####`home`

Vaule put into sysconfig file of openfire install dir.
Default is '/opt/openfire'.

####`user`

User that the JVM should be run as, defaults to `daemon`.

####`group`

Group that the JVM should be run as, defaults to `daemon`.

####`pidfile`

Path to the pid file. Defaults to '/var/run/openfire.pid'.

####`logdir`

Where should the log files be sotred, default is '/var/log/openfire'.


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
