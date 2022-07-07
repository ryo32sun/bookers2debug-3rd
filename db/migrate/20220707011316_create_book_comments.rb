class CreateBookComments < ActiveRecord::Migration[6.1]
  def change
    create_table :book_comments do |t|

      t.timestamps
      t.string :comment
      t.integer :user_id
      t.integer :book_id
    end
  end
end
