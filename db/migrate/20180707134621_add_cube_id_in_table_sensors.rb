class AddCubeIdInTableSensors < ActiveRecord::Migration[5.2]
  def change
    add_column :sensors, :cube_id, :string
  end
end
