class DeleteIntervalInTableSensors < ActiveRecord::Migration[5.1]
  def change
  	remove_column :sensors, :interval
  end
end
