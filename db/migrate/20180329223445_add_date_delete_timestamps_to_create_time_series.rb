class AddDateDeleteTimestampsToCreateTimeSeries < ActiveRecord::Migration[5.1]
  def change
    add_column :time_series, :time, :timestamp
  end
end
