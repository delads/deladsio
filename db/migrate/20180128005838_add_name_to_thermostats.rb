class AddNameToThermostats < ActiveRecord::Migration[5.1]
  def change
    add_column :thermostats, :name, :string
  end
end
