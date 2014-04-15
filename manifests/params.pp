# Default params
class remctl::params {

  case $::osfamily {
    'RedHat': {
      $acldir                       = '/etc/remctl/acl'
      $confdir                      = '/etc/remctl/conf.d'
      $conffile                     = '/etc/remctl.conf'
      $install                      = true
      $parent_folders               = ['/etc/remctl']

      $server_package_name          = 'remctl'
      $server_package_ensure        = 'latest'

      $client_package_name          = $server_package_name
      $client_package_ensure        = $server_package_ensure

      $remctl_xinetd                = true
      $remctl_xinetd_access_times   = undef
      $remctl_xinetd_bind           = undef
      $remctl_xinetd_cps            = undef
      $remctl_xinetd_disable        = 'no'
      $remctl_xinetd_ensure         = 'present'
      $remctl_xinetd_flags          = undef
      $remctl_xinetd_group          = 'root'
      $remctl_xinetd_groups         = undef
      $remctl_xinetd_instances      = undef
      $remctl_xinetd_log_on_failure = undef
      $remctl_xinetd_log_on_success = undef
      $remctl_xinetd_log_type       = undef
      $remctl_xinetd_no_access      = undef
      $remctl_xinetd_only_from      = undef
      $remctl_xinetd_per_source     = undef
      $remctl_xinetd_port           = '4373'
      $remctl_xinetd_protocol       = 'tcp'
      $remctl_xinetd_server         = '/usr/sbin/remctld'
      $remctl_xinetd_server_args    = undef
      $remctl_xinetd_service_name   = 'remctl'
      $remctl_xinetd_socket_type    = 'stream'
      $remctl_xinetd_user           = 'root'
      $remctl_xinetd_wait           = undef
      $remctl_xinetd_xtype          = undef
    }
    'Debian': {
      $acldir                       = '/etc/remctl/acl'
      $confdir                      = '/etc/remctl/conf.d'
      $conffile                     = '/etc/remctl/remctl.conf'
      $install                      = true
      $parent_folders               = ['/etc/remctl']

      $server_package_name          = 'remctl-server'
      $server_package_ensure        = 'latest'

      $client_package_name          = 'remctl-client'
      $client_package_ensure        = 'latest'

      $remctl_xinetd                = true
      $remctl_xinetd_access_times   = undef
      $remctl_xinetd_bind           = undef
      $remctl_xinetd_cps            = undef
      $remctl_xinetd_disable        = 'no'
      $remctl_xinetd_ensure         = 'present'
      $remctl_xinetd_flags          = undef
      $remctl_xinetd_group          = 'root'
      $remctl_xinetd_groups         = undef
      $remctl_xinetd_instances      = undef
      $remctl_xinetd_log_on_failure = undef
      $remctl_xinetd_log_on_success = undef
      $remctl_xinetd_log_type       = undef
      $remctl_xinetd_no_access      = undef
      $remctl_xinetd_only_from      = undef
      $remctl_xinetd_per_source     = undef
      $remctl_xinetd_port           = '4373'
      $remctl_xinetd_protocol       = 'tcp'
      $remctl_xinetd_server         = '/usr/sbin/remctld'
      $remctl_xinetd_server_args    = undef
      $remctl_xinetd_service_name   = 'remctl'
      $remctl_xinetd_socket_type    = 'stream'
      $remctl_xinetd_user           = 'root'
      $remctl_xinetd_wait           = undef
      $remctl_xinetd_xtype          = undef
    }
    default: {
      fail("remctl: module does not support osfamily ${::osfamily}. You are welcome to submit the proper default values for your osfamily to the module author.")
    }
  }
}
