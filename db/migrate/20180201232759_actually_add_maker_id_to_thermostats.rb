class ActuallyAddMakerIdToThermostats < ActiveRecord::Migration[5.1]
  def change
    add_column :thermostats, :maker_id, :integer
  end
end
