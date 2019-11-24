class ChangeAuthorCols < ActiveRecord::Migration[6.0]
  def change
    remove_column :authors, :gender, :string
    add_column :authors, :gender, :integer
  end
end
