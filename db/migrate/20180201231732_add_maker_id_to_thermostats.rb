class AddMakerIdToThermostats < ActiveRecord::Migration[5.1]
  def change
    add_column :makers, :maker_id, :integer
  end
end
