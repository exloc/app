class AddCodeExamples < ActiveRecord::Migration[5.0]
  def change
    create_table :code_examples do |t|
      t.belongs_to :user, null: false
      t.string :slug, null: false
      t.string :git
      t.string :name
      t.string :description
      t.text :content
      t.jsonb :exloc_metadata, null: false, default: "{}"
      t.jsonb :repository_metadata, null: false, default: "{}"
      t.timestamps null: false
    end

    add_index :code_examples, :slug, unique: true
  end
end
