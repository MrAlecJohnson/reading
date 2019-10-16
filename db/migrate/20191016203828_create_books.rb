class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :firstname
      t.string :lastname
      t.string :sex
      t.integer :published
      t.date :finished
      t.integer :rating
      t.boolean :owned
      t.text :tags

      t.timestamps
    end
  end
end
