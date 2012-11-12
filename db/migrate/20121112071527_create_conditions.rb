class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.references :location
      t.decimal :temp, :precision => 1
      t.string :wind_direction
      t.integer :wind_speed

      t.timestamps
    end
    add_index :conditions, :location_id
    add_index :conditions, :created_at
  end
end
