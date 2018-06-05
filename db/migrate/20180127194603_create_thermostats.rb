class CreateThermostats < ActiveRecord::Migration[5.1]
  def change
    create_table :thermostats do |t|
      t.float :temperature
      t.integer :max_temperature, :interval
      t.string :namespace, :mqtt_user, :mqtt_password
      t.timestamps
    end
  end
end
