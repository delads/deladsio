class AddProvisionedToTableCubes < ActiveRecord::Migration[5.2]
  def change
    add_column :cubes, :provisioned, :boolean
  end
end
