# Use the xinetd module to install and configure xinetd for remctl.
# Uses the name inetd to keep name collisions down.
class remctl::server::inetd {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  class { 'xinetd':
    confdir            => $remctl::server::xinetd_confdir,
    conffile           => $remctl::server::xinetd_conffile,
    package_name       => $remctl::server::xinetd_package_name,
    service_name       => $remctl::server::xinetd_service_name,
#    service_restart    => $remctl::server::xinetd_service_restart,
#    service_status     => $remctl::server::xinetd_service_status,
#    service_hasrestart => $remctl::server::xinetd_service_hasrestart,
#    service_hasstatus  => $remctl::server::xinetd_service_hasstatus,
  }

  xinetd::service { 'remctl':
    ensure         => $remctl::server::remctl_xinetd_ensure,
    access_times   => $remctl::server::remctl_xinetd_access_times,
    bind           => $remctl::server::remctl_xinetd_bind,
    cps            => $remctl::server::remctl_xinetd_cps,
    disable        => $remctl::server::remctl_xinetd_disable,
    flags          => $remctl::server::remctl_xinetd_flags,
    group          => $remctl::server::remctl_xinetd_group,
    groups         => $remctl::server::remctl_xinetd_groups,
    instances      => $remctl::server::remctl_xinetd_instances,
    log_on_failure => $remctl::server::remctl_xinetd_log_on_failure,
#    log_on_success => $remctl::server::remctl_xinetd_log_on_success,
    log_type       => $remctl::server::remctl_xinetd_log_type,
    no_access      => $remctl::server::remctl_xinetd_no_access,
    only_from      => $remctl::server::remctl_xinetd_only_from,
    per_source     => $remctl::server::remctl_xinetd_per_source,
    port           => $remctl::server::remctl_xinetd_port,
    protocol       => $remctl::server::remctl_xinetd_protocol,
    server         => $remctl::server::remctl_xinetd_server,
    server_args    => $remctl::server::remctl_xinetd_server_args,
    service_name   => $remctl::server::remctl_xinetd_service_name,
    service_type   => $remctl::server::remctl_xinetd_service_type,
    user           => $remctl::server::remctl_xinetd_user,
    wait           => $remctl::server::remctl_xinetd_wait,
    xtype          => $remctl::server::remctl_xinetd_xtype,
  }
}
