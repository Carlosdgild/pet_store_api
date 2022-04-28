# frozen_string_literal: true

module Sequences
  module Tag
    module_function

    def tag(number = SecureRandom.random_number(100))
      "pet_tag_#{number}"
    end
  end
end
