require 'spec_helper'

oses = @oses

describe 'remctl::server::command' do

  oses.each do |osname, os|

    describe "Running on #{osname}" do

      let :facts do {
        :operatingsystem           => os[:operatingsystem],
        :operatingsystemmajrelease => os[:operatingsystemmajrelease],
        :osfamily                  => os[:osfamily],
      } end

      let :params do {
        :executable_path => '/usr/local/bin',
        :commands        => [
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
            'options'    => 'logmask=2',
            'acl'        => 'ANYUSER',
          },
          {
            'subcommand' => 'password',
            'executable' => 'dopassword',
            'options'    => { 'logmask' => '3', },
            'acl'        => '/etc/acl/group1',
          },
          {
            'command'    => 'printing',
            'subcommand' => 'ALL',
            'executable' => '/usr/bin/printthing',
            'acl'        => '/etc/acl/group1',
          },
          'other do /usr/local/bin/otherthing /etc/acl/group1',
        ],
      } end

      let :title do 'accounts' end

      it 'Should create #{os[:confdir]}/accounts with example contents' do
        should contain_file("#{os[:confdir]}/accounts").with({
          'ensure'  => 'file',
          'group'   => 'root',
          'mode'    => '0644',
          'owner'   => 'root',
          'content' => /^accounts view \/usr\/local\/bin\/doaccount logmask=2 ANYUSER$/,
        })
      end

    end

  end

end
