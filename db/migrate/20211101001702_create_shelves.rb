class CreateShelves < ActiveRecord::Migration[6.1]
  def change
    create_table :shelves do |t|
      t.string :shelf_code, null: false, default: ''

      t.timestamps
    end
  end
end
