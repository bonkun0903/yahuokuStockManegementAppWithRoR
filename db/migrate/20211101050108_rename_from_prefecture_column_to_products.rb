class RenameFromPrefectureColumnToProducts < ActiveRecord::Migration[6.1]
  def change
    rename_column :products, :from_prefecture, :prefecture_id
  end
end
