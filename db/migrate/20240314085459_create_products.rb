class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :amount
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
