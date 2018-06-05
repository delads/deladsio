class CreateTimeSeries < ActiveRecord::Migration[5.1]
  def change
    create_table :time_series do |t|
      t.timestamps
      t.string :sensor_id
      t.float :property_value
    end
  end
end
