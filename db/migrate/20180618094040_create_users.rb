class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :device_id, unique: true
      t.string :nickname, unique: true

      t.timestamps
    end
    add_index :users, [:device_id, :nickname], unique: true
  end
end
