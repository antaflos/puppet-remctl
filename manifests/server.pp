# Installs and configures remctl (and xinetd) and remctl acls and config files.
#
# By default, remctl runs as root and the programs it runs are responsible
# for dropping privileges where appropriate.  If all of the programs you
# run are run by the same user, you may wish to start remctld as a user
# other than root.  If you do, it will still need to be able to read the
# host keytab (or some other keytab, if you specify a different principal
# in the client).
#
# Requires keytab to be synced with some other process (we do ours by hand).
class remctl::server (
  $acldir                       = $remctl::params::acldir,
  $confdir                      = $remctl::params::confdir,
  $conffile                     = $remctl::params::conffile,
  $install                      = $remctl::params::install,
  $package_name                 = $remctl::params::server_package_name,
  $package_ensure               = $remctl::params::server_package_ensure,
  $parent_folders               = $remctl::params::parent_folders,

  $remctl_xinetd                = $remctl::params::remctl_xinetd,
  $remctl_xinetd_access_times   = $remctl::params::remctl_xinetd_access_times,
  $remctl_xinetd_bind           = $remctl::params::remctl_xinetd_bind,
  $remctl_xinetd_cps            = $remctl::params::remctl_xinetd_cps,
  $remctl_xinetd_disable        = $remctl::params::remctl_xinetd_disable,
  $remctl_xinetd_ensure         = $remctl::params::remctl_xinetd_ensure,
  $remctl_xinetd_flags          = $remctl::params::remctl_xinetd_flags,
  $remctl_xinetd_group          = $remctl::params::remctl_xinetd_group,
  $remctl_xinetd_groups         = $remctl::params::remctl_xinetd_groups,
  $remctl_xinetd_instances      = $remctl::params::remctl_xinetd_instances,
  $remctl_xinetd_log_on_failure = $remctl::params::remctl_xinetd_log_on_failure,
  $remctl_xinetd_log_on_success = $remctl::params::remctl_xinetd_log_on_success,
  $remctl_xinetd_log_type       = $remctl::params::remctl_xinetd_log_type,
  $remctl_xinetd_no_access      = $remctl::params::remctl_xinetd_no_access,
  $remctl_xinetd_only_from      = $remctl::params::remctl_xinetd_only_from,
  $remctl_xinetd_per_source     = $remctl::params::remctl_xinetd_per_source,
  $remctl_xinetd_port           = $remctl::params::remctl_xinetd_port,
  $remctl_xinetd_protocol       = $remctl::params::remctl_xinetd_protocol,
  $remctl_xinetd_server         = $remctl::params::remctl_xinetd_server,
  $remctl_xinetd_server_args    = $remctl::params::remctl_xinetd_server_args,
  $remctl_xinetd_service_name   = $remctl::params::remctl_xinetd_service_name,
  $remctl_xinetd_socket_type    = $remctl::params::remctl_xinetd_socket_type,
  $remctl_xinetd_user           = $remctl::params::remctl_xinetd_user,
  $remctl_xinetd_wait           = $remctl::params::remctl_xinetd_wait,
  $remctl_xinetd_xtype          = $remctl::params::remctl_xinetd_xtype,

  $xinetd_confdir               = undef,
  $xinetd_conffile              = undef,
  $xinetd_package_name          = undef,
  $xinetd_service_name          = undef,
  $xinetd_service_restart       = undef,
  $xinetd_service_status        = undef,
  $xinetd_service_hasrestart    = undef,
  $xinetd_service_hasstatus     = undef,
) inherits remctl::params {

  include stdlib

  anchor { 'remctl::server::begin': }

  if str2bool($install) {
    Anchor['remctl::server::begin'] ->
    package { $package_name:
      ensure => $package_ensure,
      notify => Class['remctl::server::inetd'],
    } ->
    Anchor['remctl::server::end']
  }

  if str2bool($remctl_xinetd) {
    Anchor['remctl::server::begin'] ->
    class { 'remctl::server::inetd': } ->
    Anchor['remctl::server::end']
  }

  Anchor['remctl::server::begin'] ->
  class { 'remctl::server::config': } ->
  Anchor['remctl::server::end']

  anchor { 'remctl::server::end': }
}
