class DeleteColumnMaxtemperatureInTableSensors < ActiveRecord::Migration[5.1]
  def change
  	remove_column :sensors, :max_temperature
  end
end
