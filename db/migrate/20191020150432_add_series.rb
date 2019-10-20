class AddSeries < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :series, :text
  end
end
