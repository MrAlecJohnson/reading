class RenameSex < ActiveRecord::Migration[6.0]
  def change
    rename_column :books, :sex, :gender
  end
end
