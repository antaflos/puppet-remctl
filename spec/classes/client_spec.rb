require 'spec_helper'

oses = @oses

describe 'remctl::client' do

  oses.each do |osname, os|

    describe "Running on #{osname}" do

      let :facts do {
        :operatingsystem           => os[:operatingsystem],
        :operatingsystemmajrelease => os[:operatingsystemmajrelease],
        :osfamily                  => os[:osfamily],
      } end

      it 'should install required packages' do
        Array(os[:client_package_name]).each do |package|
          should contain_package(package).with({
            'ensure' => os[:client_package_ensure],
          })
        end
      end

    end

  end

end
