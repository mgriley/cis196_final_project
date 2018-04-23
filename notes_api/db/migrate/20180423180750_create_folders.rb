class CreateFolders < ActiveRecord::Migration[5.1]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :parent_folder, foreign_key: true

      t.timestamps
    end
  end
end
