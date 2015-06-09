# remctl

Current build status for master branch: [![Build Status](https://travis-ci.org/NMTCC/puppet-remctl.png?branch=master)](https://travis-ci.org/NMTCC/puppet-remctl)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - Getting started with remctl](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

The remctl module installs, configures, and manages the command definitions and Access Control Lists for remctl.

## Module description

The remctl module handles installing remctl with relatively standard defaults. It also installs xinetd to handle the daemon.  Lastly, it allows for easy ACL and command definition.

## Setup

If any nonstandard configuration is needed, the remctl class may be invoked with any required options; however, just applying an ACL or command will implicitly install the server and daemon.  Standard usage might look like this:

```puppet
remctl::server::acl { 'accounts':
  principals => [
    {
      'principal' => 'baduser@EXAMPLE.ORG',
      'deny'      => true,
    },
    
    {
      'file'      => '/etc/remctl/acl/admins',
    },
    
    'deny:otherbaduser@EXAMPLE.ORG',
    
    {
      'principal' => 'service/admin@EXAMPLE.ORG',
    },
    
    'service/other@EXAMPLE.ORG',
  ],
}

remctl::server::command { 'accounts':
  executable_path => '/usr/local/bin',
  commands        => [
    {
       'subcommand' => 'create',
       'executable' => 'doaccount',
       'acl'        => ['/etc/acl/group1','/etc/acl/group3'],
    },

    {
       'subcommand' => 'delete',
       'executable' => 'doaccount',
       'acl'        => '/etc/acl/group3',
    },

    {
       'subcommand' => 'view',
       'executable' => 'doaccount',
       'acl'        => 'ANYUSER',
    },

    {
       'subcommand' => 'password',
       'executable' => 'dopasswd',
       'options'    => { 'logmask' => '3', },
       'acl'        => '/etc/acl/group1',
    },

    {
       'command'    => 'printing',
       'subcommand' => 'ALL',
       'executable' => '/usr/bin/printthing',
       'acl'        => '/etc/acl/group2',
    },

    'other do /usr/local/bin/otherthing /etc/acl/group1',
  ]
}
```

Note that the commands and ACL definitions may include hashes, allowing verbosity, or strings, allowing compactness.  The strings must be valid lines for the respective listing; see man remctld(8) for proper syntax.

## Usage

### Class `::remctl::client`

Installs the remctl client. On RedHat this is in the same package as the remctl
server program, while on Debian it has its own package. Use this class to
install just the client program (`remctl`) without installing and configuring
the remctl server (`remctld`).

#### Parameters

##### `package_name`

(optionally Array of) String: defaults to 'remctl' on RedHat and 'remctl-client' on Debian.  The name of the package for the remctl client.

##### `package_ensure`

String: defaults to 'latest'. The ensure state of the remctl client package.

### Class `::remctl::server`

For the remctl base class, each of the options for the puppetlabs/xinetd class is broken out as `xinetd_{optionname}`.  Additionally, each option for  puppetlabs/xinetd::service is broken out as `remctl_xinetd_{optionname}`.  Aside: perhaps this naming scheme isn't the best.  If you'd like to change it, see the contribution guide at the bottom of this document!

The unique options for the base class follow.  The defaults are all based on RHEL6; similar defaults are in place for other distributions.  If your distro isn't included, feel free to contribute! Again, just see the end of the document for more info.

#### Parameters

##### `acldir`

String: defaults to '/etc/remctl/acl'.  The directory that remctl ACLs are stored in.

##### `confdir`

String: defaults to '/etc/remctl/conf.d'.  The directory the command module's command listing files are stored in.

##### `conffile`

String: defaults to '/etc/remctl.conf'.  The file that the remctl daemon reads from; this file only contains an 'include $remctl::server::confdir'.

##### `install`

Boolean: defaults to true.  Whether to install the 'remctl' package(s).

##### `package_name`

(optionally Array of) String: defaults to 'remctl' on RedHat and 'remctl-server' on Debian.  The name of the package for the remctl server.

##### `package_ensure`

String: defaults to 'latest'.  The ensure state of the remctl server package.

##### `parent_folders`

Array of String: defaults to ['/etc/remctl'].  A list of folders to ensure exist for this class; used for the parent folders of $remctl::server::acldir and $remctl::server::confdir.

### Definition `::remctl::server::acl`

There is only one, required, parameter for the acl definition.  The title of the `remctl::server::acl` is the filename for the ACL under the directory $remctl::server::acldir.

#### Parameters

##### `principals`

Array of ( String | Hash ).  Required.  An ordered list of principals to insert into the ACL.  Valid hash options below.  Note that there are no required parameters, but at least one of ( file | principal | gput | pcre | regex ) should be declared.  Deny is used against one of these other types as well.  If a string is used, it must be a valid line as per man remctld(8).

#### Hash keys for principals

##### `deny`

Boolean: false if unset.  If set and set to true, deny this principal access.

##### `file`

String.  Filename of ACL to additionally include.

##### `gput`

String.  Global Privileged User Table type.  See man remctld(8).  Unsupported in standard RHEL6 install; use only if you know your version supports it.

##### `pcre`

Regex|String.  A Perl-compatible regular expression.  See man remctld(8) for more info.

##### `principal`

String.  The name of a specific principal to allow (the most common option).  If allowing all users, use '

##### `regex`

Regex|String.  Likely an alias for pcre, this is, just as it says on the tin, a regular expression.

### Definition `::remctl::server::command`

There are two parameters for the command definition.  The title of the remctl::server::command{} is the filename for the configuration file under $remctl::server::configdir that these commands are inserted into.

#### Parameters

##### `executable_path`

String.  Optional.  The default path for the executables.  Note that if no executable_path is given, and a command listing's executable isn't a fully qualified path, the manifest fails.  Note that this is not a search path, but a single directory.

##### `commands`

Array of ( String | Hash ).  Required.  An ordered list of commands to insert into the command listing.  Valid hash options below.  If using a string, it must be a valid line as per man remctld(8).

#### Hash keys for commands

##### `command`

String: defaults to the title of the `remctl::server::command` call.  Required.  The name of the command to allow from the remote client.

##### `subcommand`

String.  Required.  A subcommand name that can allow for different command options upon calling.  To expect no subcommand, use 'EMPTY', and to allow any subcommand, use 'ALL'.

##### `executable`

String.  Required.  If not a fully qualified path, defaults to "$remctl::server::command::executable_path/$executable" if $remctl::server::command::executable_path is set; otherwise (if it's not a fully qualified path), the manifest fails.  This is the executable called by remctl when this command and subcommand are encountered.

##### `options`

Hash of 'option'=>value | String.  Optional.  For the list of valid option=value pairs, see man remctld(8).  String is not parsed for validity, but should be valid, as 'option1=value1 option2=value2'.

##### `acl`

String | Array of String.  Required.  Fully-qualified path(s) for the ACL file(s) that list principals to allow for this command.  Note that this may also be a single 'princ:someuser' or 'ANYUSER'.  Basically, any valid line for an acl, as in man remctld(8).

## Limitations

This module has only been tested on RHEL6 so far; to add support for your distribution, contribute sane defaults as per the contribution note, below.

## Development

To request a feature or report a bug, use the project's Github issue tracker.

If you want to take a stab at the feature or bug yourself, or one that's already in the tracker, fork the repo, do some stuff, make sure that the specs are updated (and that rspec doesn't fail), and submit a pull request.
