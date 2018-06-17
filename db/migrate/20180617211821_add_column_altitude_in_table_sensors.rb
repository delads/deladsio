class AddColumnAltitudeInTableSensors < ActiveRecord::Migration[5.2]
  def change
    add_column :sensors, :altitude, :string
  end
end
