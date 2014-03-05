# Ensures the remctl.conf is in the right place with the right options.
# That is to say, remctl.conf should only `include /etc/remctl/conf.d` or the
# current confdir path.  Also ensures the confdir and acl_dir paths exist.
class remctl::config {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  File {
    group => 'root',
    owner => 'root',
  }

  file { $remctl::conffile:
    ensure  => 'file',
    content => "#Managed by Puppet. Do not edit.\ninclude ${remctl::confdir}\n",
    mode    => '0640',
  }

  file { $remctl::confdir:
    ensure => 'directory',
    mode   => '0755',
  }

  file { $remctl::acldir:
    ensure => 'directory',
    mode   => '0755',
  }

  if $remctl::parent_folders {
    file { $remctl::parent_folders:
      ensure => 'directory',
      mode   => '0755',
    }
  }
}
