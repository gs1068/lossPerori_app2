source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 6.1.1'
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 5.0'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'bootstrap', '~> 4.1.1'
gem 'faker',  '1.9.1'
gem 'sass-rails'
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'jquery-rails'
gem 'jp_prefecture'
gem 'carrierwave'
gem 'kaminari'
gem 'fog-aws'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'webdrivers'
  gem 'selenium-webdriver'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'rubocop-airbnb'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
