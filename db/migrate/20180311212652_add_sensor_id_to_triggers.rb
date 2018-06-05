class AddSensorIdToTriggers < ActiveRecord::Migration[5.1]
  def change
    add_column :triggers, :sensor_id, :integer
  end
end
