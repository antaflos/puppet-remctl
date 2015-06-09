require 'spec_helper'

oses = @oses

describe 'remctl::server' do

  oses.each do |osname, os|

    describe "Running on #{osname}" do

      let :facts do {
        :operatingsystem           => os[:operatingsystem],
        :operatingsystemmajrelease => os[:operatingsystemmajrelease],
        :osfamily                  => os[:osfamily],
      } end

      describe '#install' do
        context 'default' do
          it 'should install required packages' do
            Array(os[:server_package_name]).each do |package|
              should contain_package(package).with({
                'ensure' => os[:server_package_ensure],
              })
            end
            os[:parent_folders].each do |folder|
              should contain_file(folder).with({
                'ensure' => 'directory',
                'owner'  => 'root',
                'group'  => 'root',
                'mode'   => '0755',
              })
            end
            should contain_file(os[:acldir]).with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
            should contain_file(os[:confdir]).with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
            should contain_file(os[:conffile]).with({
              'ensure' => 'file',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0640',
            })
          end
        end

        context 'set to true' do
          let :params do {
            :install => 'true',
          } end

          it 'should install required packages' do
            Array(os[:server_package_name]).each do |package|
              should contain_package(package).with({
                'ensure' => os[:server_package_ensure],
              })
            end
            os[:parent_folders].each do |folder|
              should contain_file(folder).with({
                'ensure' => 'directory',
                'owner'  => 'root',
                'group'  => 'root',
                'mode'   => '0755',
              })
            end
            should contain_file(os[:acldir]).with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
            should contain_file(os[:confdir]).with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
            should contain_file(os[:conffile]).with({
              'ensure' => 'file',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0640',
            })
          end

        end

        context 'set to false' do
          let :params do {
            :install => 'false',
          } end

          it 'should NOT install packages' do
            Array(os[:server_package_name]).each do |package|
              should_not contain_package(package)
            end
            os[:parent_folders].each do |folder|
              should contain_file(folder).with({
                'ensure' => 'directory',
                'owner'  => 'root',
                'group'  => 'root',
                'mode'   => '0755',
              })
            end
            should contain_file(os[:acldir]).with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
            should contain_file(os[:confdir]).with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
            should contain_file(os[:conffile]).with({
              'ensure' => 'file',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0640',
            })
          end
        end
      end

      describe '#remctl_xinetd' do
        context 'default' do
          it 'should contain remctl::xinetd' do
            should contain_class('xinetd')
            should contain_xinetd__service('remctl').with({
              'disable'      => os[:remctl_xinetd_disable],
              'ensure'       => os[:remctl_xinetd_ensure],
              'group'        => os[:remctl_xinetd_group],
              'port'         => os[:remctl_xinetd_port],
              'protocol'     => os[:remctl_xinetd_protocol],
              'server'       => os[:remctl_xinetd_server],
              'service_name' => os[:remctl_xinetd_service_name],
              'socket_type'  => os[:remctl_xinetd_socket_type],
              'user'         => os[:remctl_xinetd_user],
            })
            os[:parent_folders].each do |folder|
              should contain_file(folder).with({
                'ensure' => 'directory',
                'owner'  => 'root',
                'group'  => 'root',
                'mode'   => '0755',
              })
            end
            should contain_file(os[:acldir]).with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
            should contain_file(os[:confdir]).with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
            should contain_file(os[:conffile]).with({
              'ensure' => 'file',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0640',
            })
          end
        end

        context 'set to true' do
          let :params do {
            :remctl_xinetd => 'true',
          } end

          it 'should contain remctl::xinetd' do
            should contain_class('xinetd')
            should contain_xinetd__service('remctl').with({
              'disable'      => os[:remctl_xinetd_disable],
              'ensure'       => os[:remctl_xinetd_ensure],
              'group'        => os[:remctl_xinetd_group],
              'port'         => os[:remctl_xinetd_port],
              'protocol'     => os[:remctl_xinetd_protocol],
              'server'       => os[:remctl_xinetd_server],
              'service_name' => os[:remctl_xinetd_service_name],
              'socket_type'  => os[:remctl_xinetd_socket_type],
              'user'         => os[:remctl_xinetd_user],
            })
            os[:parent_folders].each do |folder|
              should contain_file(folder).with({
                'ensure' => 'directory',
                'owner'  => 'root',
                'group'  => 'root',
                'mode'   => '0755',
              })
            end
            should contain_file(os[:acldir]).with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
            should contain_file(os[:confdir]).with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
            should contain_file(os[:conffile]).with({
              'ensure' => 'file',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0640',
            })
          end

        end

        context 'set to false' do
          let :params do {
            :remctl_xinetd => 'false',
          } end

          it 'should NOT contain remctl::xinetd' do
            should_not contain_class('xinetd')
            should_not contain_xinetd__service('remctl')
            os[:parent_folders].each do |folder|
              should contain_file(folder).with({
                'ensure' => 'directory',
                'owner'  => 'root',
                'group'  => 'root',
                'mode'   => '0755',
              })
            end
            should contain_file(os[:acldir]).with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
            should contain_file(os[:confdir]).with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
            should contain_file(os[:conffile]).with({
              'ensure' => 'file',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0640',
            })
          end

        end

      end

    end

  end

end
