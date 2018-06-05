class ChangeMaxTempToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :thermostats, :max_temperature, :float
  end
end
