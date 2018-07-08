class AddMakerIdToTableCubes < ActiveRecord::Migration[5.2]
  def change
    add_column :cubes, :maker_id, :string
  end
end
