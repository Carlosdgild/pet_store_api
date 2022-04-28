# frozen_string_literal: true

# == Schema Information
#
# Table name: pets
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  tag        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pets_on_name  (name)
#
FactoryBot.define do
  factory :pet do
    name { generate(:name) }
    tag { generate(:tag) }
  end
end
