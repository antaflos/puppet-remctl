require 'rubygems'
require 'rspec-puppet'
require 'puppetlabs_spec_helper/module_spec_helper'

@oses = {
  'Redhat 6' => {
    :operatingsystem            => 'RedHat',
    :operatingsystemmajrelease  => '6',
    :osfamily                   => 'RedHat',

    :acldir                     => '/etc/remctl/acl',
    :confdir                    => '/etc/remctl/conf.d',
    :conffile                   => '/etc/remctl.conf',
    :install                    => 'true',
    :parent_folders             => ['/etc/remctl'],

    :server_package_name        => 'remctl',
    :server_package_ensure      => 'latest',

    :client_package_name        => 'remctl',
    :client_package_ensure      => 'latest',

    :remctl_xinetd              => 'true',
    :remctl_xinetd_disable      => 'no',
    :remctl_xinetd_ensure       => 'present',
    :remctl_xinetd_group        => 'root',
    :remctl_xinetd_port         => '4373',
    :remctl_xinetd_protocol     => 'tcp',
    :remctl_xinetd_server       => '/usr/sbin/remctld',
    :remctl_xinetd_service_name => 'remctl',
    :remctl_xinetd_socket_type  => 'stream',
    :remctl_xinetd_user         => 'root',
  },
  'Ubuntu 12.04' => {
    :operatingsystem            => 'Ubuntu',
    :operatingsystemmajrelease  => '12',
    :osfamily                   => 'Debian',

    :acldir                     => '/etc/remctl/acl',
    :confdir                    => '/etc/remctl/conf.d',
    :conffile                   => '/etc/remctl/remctl.conf',
    :install                    => 'true',
    :parent_folders             => ['/etc/remctl'],

    :server_package_name        => 'remctl-server',
    :server_package_ensure      => 'latest',

    :client_package_name        => 'remctl-client',
    :client_package_ensure      => 'latest',

    :remctl_xinetd              => 'true',
    :remctl_xinetd_disable      => 'no',
    :remctl_xinetd_ensure       => 'present',
    :remctl_xinetd_group        => 'root',
    :remctl_xinetd_port         => '4373',
    :remctl_xinetd_protocol     => 'tcp',
    :remctl_xinetd_server       => '/usr/sbin/remctld',
    :remctl_xinetd_service_name => 'remctl',
    :remctl_xinetd_socket_type  => 'stream',
    :remctl_xinetd_user         => 'root',
  },
}
