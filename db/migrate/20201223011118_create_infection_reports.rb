# frozen_string_literal: true

class CreateInfectionReports < ActiveRecord::Migration[6.1]
  def change
    create_table :infection_reports do |t|
      t.references :survivor, null: false, foreign_key: true
      t.references :reported_survivor, null: false, foreign_key: { to_table: 'survivors' }

      t.timestamps
    end
  end
end
