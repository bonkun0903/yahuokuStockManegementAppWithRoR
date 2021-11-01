class AddColumnProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :shelf, null: false, foreign_key: true
  end
end
