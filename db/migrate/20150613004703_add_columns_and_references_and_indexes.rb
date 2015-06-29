class AddColumnsAndReferencesAndIndexes < ActiveRecord::Migration
  def change


    add_reference :comments, :user, index: true, foreign_key: true
    add_reference :posts, :user, index: true, foreign_key: true
    add_reference :posts, :category, index: true, foreign_key: true
    add_index :posts, :title
    add_index :posts, :body
    add_index :users, :email
  end
end
