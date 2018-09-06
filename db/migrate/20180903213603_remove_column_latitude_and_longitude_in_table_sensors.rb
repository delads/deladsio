class RemoveColumnLatitudeAndLongitudeInTableSensors < ActiveRecord::Migration[5.2]
  def change
    remove_column :sensors, :latitude
    remove_column :sensors, :longitude
  end
end
