class CreateSurvivors < ActiveRecord::Migration[6.1]
  def change
    create_table :survivors do |t|
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.integer :age
      t.string :name
      t.string :gender
      t.jsonb :items

      t.timestamps
    end
  end
end
