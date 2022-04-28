# frozen_string_literal: true

class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.string :name, null: false
      t.string :tag
      t.timestamps
    end

    add_index :pets, :name
  end
end
