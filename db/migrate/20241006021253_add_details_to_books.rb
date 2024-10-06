class AddDetailsToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :year, :integer
    add_column :books, :historic_context, :text
    add_column :books, :author_details, :text
  end
end
