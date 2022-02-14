source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

# Core Gems ####################################################################
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.2", ">= 7.0.2.2"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Support Gems #################################################################
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem 'cancancan'
gem 'devise'
gem "jbuilder"
gem 'kaminari'
gem "redis", "~> 4.0"
gem 'sidekiq'

# Assets Gems ##################################################################
gem 'chartkick'
gem "importmap-rails"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"

# Gems per Environment #########################################################
group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'cpf_faker'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'figaro'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem "web-console"
end
