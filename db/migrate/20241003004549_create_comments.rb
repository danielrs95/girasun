class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :book, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
