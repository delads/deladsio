class AddSigfoxIdToTableCubes < ActiveRecord::Migration[5.2]
  def change
    add_column :cubes, :sigfox_id, :string
  end
end
