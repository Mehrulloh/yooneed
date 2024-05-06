class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :amount
      t.boolean :active, default: false
      t.integer :status, null: true, default: nil

      t.timestamps
    end
  end
end
