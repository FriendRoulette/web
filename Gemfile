source 'https://rubygems.org'

gem 'rails', '4.1.0'

gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

gem 'omniauth'
gem 'omniauth-facebook'
gem 'oauth2'
gem 'devise'
gem 'koala'

gem 'redis'
gem 'redis-rails'

gem 'quiet_assets'
gem 'thin'

gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

gem 'rails_config'

gem 'redis'
gem 'redis-rails'

group :development do
	gem 'spring'
	gem 'sqlite3'
	gem 'better_errors'
	gem 'rspec-rails'

	platforms :mswin do
		gem 'tzinfo-data'
	end
end

group :test do
	gem 'selenium-webdriver'
	gem 'capybara'
end

group :production do
	gem 'pg'

	platforms :ruby do
		gem 'unicorn-rails'
	end
	
	gem 'newrelic_rpm'
  	gem 'rails_12factor'
end

group :doc do
	gem 'sdoc', '~> 0.4.0'
end