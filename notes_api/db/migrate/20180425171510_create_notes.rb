class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :name
      t.text :content
      t.references :folder, foreign_key: true
    end
  end
end
