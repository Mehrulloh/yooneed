class AddPackingTypeToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :packing_type, :integer, default: 0
  end
end
