class AddCodeExamples < ActiveRecord::Migration[5.0]
  def change
    create_table :code_examples do |t|
      t.belongs_to :user, null: false
      t.string :slug, null: false
      t.string :git
      t.json :metadata
      t.string :name
      t.string :description
      t.text :content
      t.timestamps null: false
    end

    add_index :code_examples, :slug, unique: true
  end
end
