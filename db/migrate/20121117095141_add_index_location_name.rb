class AddIndexLocationName < ActiveRecord::Migration
  def change
  	add_index :locations, :name
  end
end
