source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '= 5.2.5'
gem 'bootstrap-sass', '3.4.1'
gem 'jquery-rails'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 4.3.8'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'devise'
gem 'devise_invitable', '~>2.0.0'
gem 'cancancan'
gem 'rolify'
gem 'faker'
gem 'gimei'
gem 'rails-i18n', '~> 5.1'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# gem 'rails_12for'
gem 'kaminari'
# gem 'redis', '~> 4.0'
# gem 'bcrypt', '~> 3.1.7'
# gem 'mini_magick', '~> 4.8'
# gem 'capistrano-rails', group: :development
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rails-erd'
  gem 'factory_bot_rails', '~> 6.2.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'web-console', '>= 3.3.0'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'guard'
  gem 'guard-minitest'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rspec-rails', '~> 5.0.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
