class DropTableMakers < ActiveRecord::Migration[5.1]
  def change
    drop_table :makers
  end
end
