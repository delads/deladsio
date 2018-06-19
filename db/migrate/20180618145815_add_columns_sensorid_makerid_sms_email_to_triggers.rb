class AddColumnsSensoridMakeridSmsEmailToTriggers < ActiveRecord::Migration[5.2]
  def change
    add_column :triggers, :maker_id, :integer
    add_column :triggers, :sms, :string
    add_column :triggers, :email, :string

  end
end
