class AddStatusToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :status, :integer
  end
end
