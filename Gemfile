source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['>= 3.2']
rakeversion = ENV.key?('RAKE_VERSION') ? ENV['RAKE_VERSION'] : ['~> 10.1.0']

group :developmens, :test do
  gem 'rake', rakeversion,       :require => false
  gem 'rspec-puppet',            :require => false
  gem 'puppetlabs_spec_helper',  :require => false
  gem 'puppet-lint',             :require => false
  gem 'coveralls',               :require => false
  gem 'simplecov',               :require => false
  gem 'beaker',                  :require => false
  gem 'beaker-rspec',            :require => false
end

gem 'puppet', puppetversion
