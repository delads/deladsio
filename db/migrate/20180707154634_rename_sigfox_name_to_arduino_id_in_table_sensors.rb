class RenameSigfoxNameToArduinoIdInTableSensors < ActiveRecord::Migration[5.2]
  def change
    rename_column :sensors, :sigfox_name, :ardunio_id
  end
end
