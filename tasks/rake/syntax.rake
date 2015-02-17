require File.expand_path('../../env', __FILE__)

desc "Check puppet module syntax."
task :syntax do
  begin
    require 'puppet'
    require 'puppet/face'
  rescue LoadError
    fail 'Cannot load puppet/face, are you sure you have Puppet 2.7?'
  end

  # FIXME: We shouldn't need to do this. puppet/face should. See:
  # - http://projects.puppetlabs.com/issues/15529
  # - https://groups.google.com/forum/#!topic/puppet-dev/Yk0WC1JZCg8/discussion
  if (Puppet::PUPPETVERSION.to_i >= 3 && !Puppet.settings.app_defaults_initialized?)
    Puppet.initialize_settings
  end

  puts "Checking puppet module syntax..."

  success = true

  FileList['**/*.pp'].each do |manifest|
    puts "Evaluating syntax for #{manifest}"
    begin
      Puppet::Face[:parser, '0.0.1'].validate(manifest) 
    rescue Puppet::Error => error
      puts error.message
      success = false
    end
  end

  abort "Checking puppet module syntax FAILED" if success.is_a?(FalseClass)
end
