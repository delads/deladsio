class RenameColumnMqttuserToMqtttokenInTableSensors < ActiveRecord::Migration[5.1]
  def change
  	rename_column :sensors, :mqtt_user, :mqtt_token
  end
end
