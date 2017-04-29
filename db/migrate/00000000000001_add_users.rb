class AddUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :role, default: "user", null: false
      t.string :name
      t.string :nickname
      t.string :email
      t.string :image
      t.string :location
      t.jsonb :urls, null: false, default: "[]"
      t.string :token, null: false
      t.timestamps null: false
    end

    add_index :users, [:provider, :uid], unique: true
    add_index :users, :token, unique: true
  end
end
