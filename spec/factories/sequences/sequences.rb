# frozen_string_literal: true

FactoryBot.define do
  sequence(:name) do |n|
    Sequences::Name.name(n)
  end

  sequence(:tag) do |n|
    Sequences::Tag.tag(n)
  end
end
