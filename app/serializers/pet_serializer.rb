# frozen_string_literal: true

#
# Common serializer for Pet
#
class PetSerializer < ActiveModel::Serializer
  attributes %i[
    id
    name
    tag
  ]
end
