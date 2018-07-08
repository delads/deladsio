class CreateTableCubes < ActiveRecord::Migration[5.2]
  def change
    create_table :table_cubes do |t|
      t.string :name, :description, :default_graph
      t.timestamps
    end
  end
end
