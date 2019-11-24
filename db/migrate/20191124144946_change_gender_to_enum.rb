class ChangeGenderToEnum < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :gender, :string
    add_column :books, :gender, :integer
  end
end
