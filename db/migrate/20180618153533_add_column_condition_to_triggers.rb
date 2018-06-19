class AddColumnConditionToTriggers < ActiveRecord::Migration[5.2]
  def change
    add_column :triggers, :condition, :string
  end
end
