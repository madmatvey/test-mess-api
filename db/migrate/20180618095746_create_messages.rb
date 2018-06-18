class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :chat, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :messages, [:chat_id, :user_id]
  end
end
