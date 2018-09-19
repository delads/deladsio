class AddColumnSensorIdToTimeSeries < ActiveRecord::Migration[5.2]
  def change
    add_column :time_series, :sensor_id, :integer
  end
end
