# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem "rails", "~> 6.1.4", ">= 6.1.4.1"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.2.3"


# Use Puma as the app server

gem "puma", "~> 5.5.2", ">= 5.1.1"

# Reduces boot times through caching; required in config/boot.rb

gem "bootsnap", ">= 1.9.3", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible

gem "rack-cors", "~> 1.1.1", ">= 1.1.1"

gem "active_model_serializers", "~> 0.10.0"

gem "kaminari", "~> 1.2", ">= 1.2.2"

gem "rswag-api", "~> 2.4"
gem "rswag-ui", "~> 2.4"

# Windows does not include zone info files, so bundle the tzinfo-data gem

gem "tzinfo-data", "~> 1.2022", ">= 1.2022.1", platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem "brakeman", "~> 5.2", ">= 5.2.2", require: false

  gem "byebug", "~> 11.1", ">= 11.1.3", platforms: %i[mri mingw x64_mingw]

  gem "dotenv-rails", "~> 2.7", ">= 2.7.6"

  gem "factory_bot_rails", "~> 6.2"

  gem "faker", "~> 2.20"

  gem "fasterer", "~> 0.9.0"

  gem "pry", "~> 0.14.1"

  gem "reek", "~> 6.1"

  gem "rspec", "~> 3.11"

  gem "rspec-rails", "~> 5.1", ">= 5.1.1"

  gem "rswag-specs", "~> 2.5", ">= 2.5.1"

  gem "rubocop", "~> 1.27", require: false

  gem "rubocop-performance", "~> 1.13", ">= 1.13.3", require: false

  gem "rubocop-rails", "~> 2.14", ">= 2.14.2", require: false

  gem "rubocop-rspec", "~> 2.9", require: false

  gem "shoulda-matchers", "~> 5.1"
end

group :development do
  gem "annotate", "~> 3.2"

  gem "better_errors", "~> 2.9", ">= 2.9.1"

  gem "binding_of_caller", "~> 1.0"

  gem "listen", "~> 3.7", ">= 3.7.1"

  gem "rack-mini-profiler", "~> 3.0", require: false

  gem "sql_queries_count", "~> 0.0.1"

  # For memory profiling

  gem "memory_profiler", "~> 1.0"
end

group :test do
  gem "simplecov", "~> 0.21.2"
end
