class AddSigfoxIdInTableSensors < ActiveRecord::Migration[5.2]
  def change
    add_column :sensors, :sigfox_id, :string
  end
end
