class RenameTableThermostatsToSensors < ActiveRecord::Migration[5.1]
  def change
    rename_table :thermostats, :sensors
  end
end
