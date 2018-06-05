class CreateTriggers < ActiveRecord::Migration[5.1]
    def change
      create_table :triggers do |t|
        t.float :value
        t.string :name, :webhook_url
        t.timestamps
      end
    end
end
