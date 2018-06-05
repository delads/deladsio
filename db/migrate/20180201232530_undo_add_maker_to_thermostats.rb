class UndoAddMakerToThermostats < ActiveRecord::Migration[5.1]
  def change
    remove_column :makers, :maker_id
  end
end
