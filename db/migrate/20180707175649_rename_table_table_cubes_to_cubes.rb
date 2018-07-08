class RenameTableTableCubesToCubes < ActiveRecord::Migration[5.2]
  def change
    rename_table :table_cubes, :cubes
  end
end
