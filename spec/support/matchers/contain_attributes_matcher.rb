# frozen_string_literal: true

RSpec::Matchers.define(:contain_attributes) do |expected_attributes|
  match do |actual|
    # actual is a Hash object, like this:
    # { "foo" => { "name" => "bar" } }

    actual_indifferent_hash = actual.is_a?(Hash) ? HashWithIndifferentAccess.new(actual) : actual
    expected_attributes = Array(expected_attributes)

    expect(actual_indifferent_hash).to match(hash_including(*expected_attributes.map(&:to_s)))
  end
end
