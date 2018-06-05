class RenameColumnTemperatureToValueInTableSensors < ActiveRecord::Migration[5.1]
  def change
    rename_column :sensors, :temperature, :property_value
  end
end
