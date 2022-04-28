# frozen_string_literal: true

require "rails_helper"

RSpec.describe Pet, type: :model do
  subject(:pet) { create(:pet) }

  describe "validations" do
    it do
      expect(pet).to validate_presence_of(:name)
    end
  end

  describe "associations" do
    it do
      expect(pet).to have_db_index(:name)
    end
  end
end
