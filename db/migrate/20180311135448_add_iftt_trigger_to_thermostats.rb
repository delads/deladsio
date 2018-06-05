class AddIfttTriggerToThermostats < ActiveRecord::Migration[5.1]
  def change
    add_column :thermostats, :ifttt, :string
  end
end
