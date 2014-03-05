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
    :package_name               => 'remctl',
    :package_ensure             => 'latest',
    :parent_folders             => ['/etc/remctl'],

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
