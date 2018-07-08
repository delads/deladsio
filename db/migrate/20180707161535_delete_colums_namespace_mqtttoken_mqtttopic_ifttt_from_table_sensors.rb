class DeleteColumsNamespaceMqtttokenMqtttopicIftttFromTableSensors < ActiveRecord::Migration[5.2]
  def change
    remove_column :sensors, :namespace 
    remove_column :sensors, :mqtt_token 
    remove_column :sensors, :mqtt_topic 
    remove_column :sensors, :ifttt
  end
end
