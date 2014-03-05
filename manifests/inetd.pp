# Use the xinetd module to install and configure xinetd for remctl.
# Uses the name inetd to keep name collisions down.
class remctl::inetd {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  class { 'xinetd':
    confdir            => $remctl::xinetd_confdir,
    conffile           => $remctl::xinetd_conffile,
    package_name       => $remctl::xinetd_package_name,
    service_name       => $remctl::xinetd_service_name,
#    service_restart    => $remctl::xinetd_service_restart,
#    service_status     => $remctl::xinetd_service_status,
#    service_hasrestart => $remctl::xinetd_service_hasrestart,
#    service_hasstatus  => $remctl::xinetd_service_hasstatus,
  }

  xinetd::service { 'remctl':
    ensure         => $remctl::remctl_xinetd_ensure,
    access_times   => $remctl::remctl_xinetd_access_times,
    bind           => $remctl::remctl_xinetd_bind,
    cps            => $remctl::remctl_xinetd_cps,
    disable        => $remctl::remctl_xinetd_disable,
    flags          => $remctl::remctl_xinetd_flags,
    group          => $remctl::remctl_xinetd_group,
    groups         => $remctl::remctl_xinetd_groups,
    instances      => $remctl::remctl_xinetd_instances,
    log_on_failure => $remctl::remctl_xinetd_log_on_failure,
#    log_on_success => $remctl::remctl_xinetd_log_on_success,
    log_type       => $remctl::remctl_xinetd_log_type,
    no_access      => $remctl::remctl_xinetd_no_access,
    only_from      => $remctl::remctl_xinetd_only_from,
    per_source     => $remctl::remctl_xinetd_per_source,
    port           => $remctl::remctl_xinetd_port,
    protocol       => $remctl::remctl_xinetd_protocol,
    server         => $remctl::remctl_xinetd_server,
    server_args    => $remctl::remctl_xinetd_server_args,
    service_name   => $remctl::remctl_xinetd_service_name,
    service_type   => $remctl::remctl_xinetd_service_type,
    user           => $remctl::remctl_xinetd_user,
    wait           => $remctl::remctl_xinetd_wait,
    xtype          => $remctl::remctl_xinetd_xtype,
  }
}
