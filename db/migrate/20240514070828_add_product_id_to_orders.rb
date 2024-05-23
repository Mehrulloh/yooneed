class AddProductToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :product, index: true
  end
end
