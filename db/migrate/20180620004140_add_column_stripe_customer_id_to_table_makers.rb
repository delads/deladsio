class AddColumnStripeCustomerIdToTableMakers < ActiveRecord::Migration[5.2]
  def change
    add_column :makers, :stripe_customer_id, :string
  end
end
