class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :category, null: false, default: 0
      t.string :title, null: false, default: ''
      t.text :description, null: false
      t.integer :start_price, null: false, default: 10000
      t.integer :count, null: false, default: 1
      t.integer :period, null: false, default: 5
      t.integer :end_time, null: false, default: 13
      t.integer :from_prefecture, null: false, default: 33
      t.integer :shipping_fee_defrayer, null: false, default: 0
      t.integer :payment_timing, null: false, default: 0
      t.integer :fee, null: false, default: 0
      t.integer :product_status, null: false, default: 3
      t.boolean :returnable, null: false, default: false
      t.text :return_remark, null: false
      t.json :image, null: false
      t.boolean :automatic_extension, null: false, default: true
      t.integer :buyout_price, null: false, default: 0
      t.integer :automatic_relist, null: false, default: 3
      t.integer :automatic_price_cut, null: false, default: 0
      t.integer :delivery_method, null: false, default: 0
      # t.references :shelf, foreign_key: true
      t.integer :inventory_status, null: false, default: 0
      t.boolean :zip_exported, null: false, default: false
      t.boolean :inventory_seal_exported, null: false, default: false
      t.timestamps
    end
  end
end
