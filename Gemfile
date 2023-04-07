source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "bootstrap-sass"
gem "bootstrap"
gem "sass-rails"

gem 'irb'
gem 'pg'
gem 'newrelic-slack-ruby-bot'
gem 'slack-ruby-bot-server', '>= 1.1.0'
gem 'slack-ruby-bot-server-events'
gem 'slack-ruby-client'

gem 'activerecord', require: 'active_record'
gem 'otr-activerecord'
gem 'pagy_cursor'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'database_cleaner-mongoid'
  gem 'fabrication'
  gem 'faker'
  gem 'rack-test'
  gem 'rake'
  gem 'rspec'
  gem 'selenium-webdriver'
  gem 'vcr'
  gem 'webmock'
  gem 'webrick'
end
