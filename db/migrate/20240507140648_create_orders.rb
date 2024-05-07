class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :amount
      t.integer :user_id, default: User.first
      t.string :status

      t.timestamps
    end
  end
end
