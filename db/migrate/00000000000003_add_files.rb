class AddFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :files do |t|
      t.belongs_to :code_example, null: false
      t.string :name, null: false
      t.jsonb :metadata
    end
  end
end
