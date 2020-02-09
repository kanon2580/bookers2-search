class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :book_id
      t.integer :user_id

      t.timestamps
    end
    add_index :favorites, [:user_id, :book_id], unique: true
  end
end
