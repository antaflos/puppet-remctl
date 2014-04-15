# Ensures the remctl.conf is in the right place with the right options.
# That is to say, remctl.conf should only `include /etc/remctl/conf.d` or the
# current confdir path.  Also ensures the confdir and acl_dir paths exist.
class remctl::server::config {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  File {
    group => 'root',
    owner => 'root',
  }

  file { $remctl::server::conffile:
    ensure  => 'file',
    content => "#Managed by Puppet. Do not edit.\ninclude ${remctl::server::confdir}\n",
    mode    => '0640',
  }

  file { $remctl::server::confdir:
    ensure => 'directory',
    mode   => '0755',
  }

  file { $remctl::server::acldir:
    ensure => 'directory',
    mode   => '0755',
  }

  if $remctl::server::parent_folders {
    file { $remctl::server::parent_folders:
      ensure => 'directory',
      mode   => '0755',
    }
  }
}
