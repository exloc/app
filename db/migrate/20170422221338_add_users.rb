class AddUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :role, default: "user", null: false
      t.string :email
      t.string :name
      t.string :avatar_url
      t.string :location
      t.string :token
      t.timestamps null: false
    end

    add_index :users, :token, unique: true
  end
end
