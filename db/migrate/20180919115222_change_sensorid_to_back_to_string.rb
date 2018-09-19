class ChangeSensoridToBackToString < ActiveRecord::Migration[5.2]
  def change
    change_column :time_series, :sensor_id, :string
  end
end
