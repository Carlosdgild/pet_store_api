# frozen_string_literal: true

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap" # Speed up boot time by caching expensive operations.
environment = ENV.fetch("RAILS_ENV", "development")
Bootsnap.setup(
  cache_dir:            "tmp/cache", # Path to your cache
  development_mode:     environment == "development", # Current working environment, e.g. RACK_ENV, RAILS_ENV, etc
  load_path_cache:      true, # Optimize the LOAD_PATH with a cache
  # autoload_paths_cache: true,                 # Optimize ActiveSupport autoloads with cache
#   disable_trace:        false,                # Set `RubyVM::InstructionSequence.compile_option = { trace_instruction: false }`
  compile_cache_iseq:   false, # Compile Ruby code into ISeq cache, breaks coverage reporting.
  compile_cache_yaml:   true # Compile YAML into a cache
)
