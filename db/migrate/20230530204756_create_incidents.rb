# frozen_string_literal: true

class CreateIncidents < ActiveRecord::Migration[7.0]
  def change
    create_table :incidents do |t|
      t.string :title, null: false
      t.string :description
      t.integer :severity
      t.string :author
      t.timestamps
    end
  end
end
