class UpdateConditionsChangeTempScale < ActiveRecord::Migration
  def change
  	change_column :conditions, :temp, :decimal, :precision => 5, :scale => 1
  end
end
