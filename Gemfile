source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bootsnap"
gem "puma"
gem "rails", "5.2.0rc1"
gem "sass-rails", github: "rails/sass-rails"
gem "sqlite3"

gem "coffee-rails"
gem "jbuilder"
gem "turbolinks"
gem "uglifier"

gem "capistrano-rails", group: :development

gem "awesome_print"
gem "webpacker"
gem 'simple_form'
gem 'bootstrap-sass', '~> 3.4.0'
gem 'sassc-rails', '>= 2.0.0'
gem 'jquery-rails'
gem 'pry'

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "capybara"
  gem "pry-rails"
  gem "pry-rescue"
  gem "rspec-rails"
  gem "rubocop"
  gem "selenium-webdriver"
end

group :development do
  gem "listen"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen"
  gem "web-console"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem 'simplecov', require: false, group: :test
gem "haml-rails", "~> 1.0"
