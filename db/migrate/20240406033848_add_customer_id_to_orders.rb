class AddCustomerIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :customer_id, :integer
    add_column :orders, :address, :string
    add_column :orders, :name, :string
    add_column :orders, :postage, :integer
    add_column :orders, :total_payment, :integer
    add_column :orders, :payment_method, :integer
  end
end
