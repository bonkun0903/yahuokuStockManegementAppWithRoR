class AddColumnProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :shelf, foreign_key: true
  end
end
