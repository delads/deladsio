class AddColumnLatitudeAndLongitudeInTableCubes < ActiveRecord::Migration[5.2]
  def change
    add_column :cubes, :latitude, :float
    add_column :cubes, :longitude, :float
  end
end
