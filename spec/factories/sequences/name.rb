# frozen_string_literal: true

module Sequences
  module Name
    module_function

    def name(number = SecureRandom.random_number(100))
      "pet_test_#{number}"
    end
  end
end
