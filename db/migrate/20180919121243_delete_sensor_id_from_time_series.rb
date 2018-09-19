class DeleteSensorIdFromTimeSeries < ActiveRecord::Migration[5.2]
  def change
    remove_column :time_series, :sensor_id 
  end
end
