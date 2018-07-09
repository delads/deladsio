class ChangeColumnNameArdunioToArduinoInTableSensors < ActiveRecord::Migration[5.2]
  def change
    rename_column :sensors, :ardunio_id, :arduino_id
  end
end
