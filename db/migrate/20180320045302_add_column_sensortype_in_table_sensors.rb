class AddColumnSensortypeInTableSensors < ActiveRecord::Migration[5.1]
  def change
  	add_column :sensors, :sensor_type, :string
  end
end
