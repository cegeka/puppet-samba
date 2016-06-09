require 'spec_helper_acceptance'

describe 'puppet::samba' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include ::samba
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file '/etc/samba/smb.conf' do
      it { is_expected.to be_file }
      its(:content) { should contain /global/ }
    end

  end
end

