class CreateTeastores < ActiveRecord::Migration[5.0]
  def change
    create_table :teastores do |t|
      t.string :name
      t.text :description
      t.string :thumb
      t.string :price

      t.timestamps
    end
  end
end
