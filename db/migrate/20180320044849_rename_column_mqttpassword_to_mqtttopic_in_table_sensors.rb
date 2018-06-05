class RenameColumnMqttpasswordToMqtttopicInTableSensors < ActiveRecord::Migration[5.1]
  def change
  	rename_column :sensors, :mqtt_password, :mqtt_topic
  end
end
