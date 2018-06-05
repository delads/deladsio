class CreateMakers < ActiveRecord::Migration[5.1]
  def change
    create_table :makers do |t|
      t.string :makername
      t.string :email
      t.string :password_digest
      t.timestamps
    end
  end
end
