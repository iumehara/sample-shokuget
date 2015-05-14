source 'https://rubygems.org'
ruby "2.1.2"

gem 'rails', '~> 4.1.0'

gem 'pg'
gem 'unicorn'

gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'angularjs-rails'

gem 'dalli'
gem 'memcachier'

gem 'bcrypt', '~> 3.1.7'
gem 'newrelic_rpm'

gem 'paperclip', github: 'thoughtbot/paperclip'
gem 'aws-sdk'

gem 'twitter'
gem 'koala'

# gem 'turbolinks'

group :production, :staging do
  gem 'rails_12factor'
end

group :development do
  gem 'annotate', '~> 2.4.1.beta'
	# gem 'debugger'
end

group :test do
  gem "capybara"
  gem 'webmock'
  gem 'launchy'
end

group :development, :test do
  gem "rspec-rails"
  gem 'factory_girl'
end