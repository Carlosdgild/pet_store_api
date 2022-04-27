# frozen_string_literal: true

RSpec.configure do |config|
  config.swagger_dry_run = true if Rails.env.test?
end
