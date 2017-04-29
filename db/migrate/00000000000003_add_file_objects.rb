class AddFileObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :file_objects do |t|
      t.belongs_to :code_example, null: false
      t.string :name, null: false
      t.integer :size, null: false, default: 0
      t.string :file_type, null: false, default: :file
      t.string :url
      # t.jsonb :metadata, null: false, default: "{}"
    end
  end
end
