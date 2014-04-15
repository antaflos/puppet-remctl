require 'spec_helper'

oses = @oses

describe 'remctl::server::acl' do

  oses.each do |osname, os|

    describe "Running on #{osname}" do

      let :facts do {
        :operatingsystem           => os[:operatingsystem],
        :operatingsystemmajrelease => os[:operatingsystemmajrelease],
        :osfamily                  => os[:osfamily],
      } end

      let :params do 
      {
        :principals => [
          {
            'principal' => 'baduser@EXAMPLE.ORG',
            'deny'      => true,
          },
          {
            'file'      => '/etc/remctl/acl/admins',
          },
          'deny:otherbaduser@EXAMPLE.ORG',
          {
            'principal' => 'service/admin@EXAMPLE.ORG',
          },
          'service/other@EXAMPLE.ORG',
        ]
      }
      end

      let :title do 'accounts' end

      it 'Should create #{os[:acldir]}/accounts with example contents' do
        should contain_file("#{os[:acldir]}/accounts").with({
          'ensure'  => 'file',
          'group'   => 'root',
          'mode'    => '0644',
          'owner'   => 'root',
          'content' => /^deny:otherbaduser@EXAMPLE\.ORG$/,
        })
      end

    end

  end

end
