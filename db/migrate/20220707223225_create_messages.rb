class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :user
      t.references :room
      t.text :body

      t.timestamps
    end
  end
end
