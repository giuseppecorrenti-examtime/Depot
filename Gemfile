source 'http://rubygems.org'

gem 'rails', '3.2.0'
gem 'sqlite3'
gem 'thin'
gem 'devise'
gem 'jquery-rails'
gem 'haml-rails'
gem 'compass', "~> 0.12.alpha.0" # Look up the website
gem 'cancan'
gem 'execjs'
gem 'therubyracer'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  
end

group :development do
  gem 'annotate'
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :test do
  gem 'turn', :require => false
  gem 'simplecov'
  gem 'simplecov-rcov'
  gem 'ci_reporter' 
  gem 'spork'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'rb-inotify', :require => false
  gem 'libnotify', :require => false
  gem 'launchy'
  gem 'database_cleaner'
end
