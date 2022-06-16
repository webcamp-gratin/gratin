class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :postage
      t.integer :subtotal
      t.integer :payment_method, default: 0
      t.string :name
      t.string :address
      t.string :postcode
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
