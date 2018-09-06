class AddColumnLatitudeAndLongitudeInTableSensors < ActiveRecord::Migration[5.2]
  def change
    add_column :sensors, :latitude, :float
    add_column :sensors, :longitude, :float
  end
end
