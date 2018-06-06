class RenameSigfoxIdToSigfoxNameInTableSensors < ActiveRecord::Migration[5.2]
  def change
    rename_column :sensors, :sigfox_id, :sigfox_name
  end
end
