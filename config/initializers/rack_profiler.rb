# frozen_string_literal: true

# https://github.com/MiniProfiler/rack-mini-profiler#caching-behavior
# Do not let rack-mini-profiler disable caching
# Rack::MiniProfiler.config.disable_caching = false # defaults to true


# https://github.com/MiniProfiler/rack-mini-profiler#configuration-options

if Rails.env.development?
  require "rack-mini-profiler"

  # initialization is skipped so trigger it
  Rack::MiniProfilerRails.initialize!(Rails.application)
end
