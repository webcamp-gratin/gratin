class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name
      t.text :description
      t.integer :no_tax
      t.boolean :is_active , default: true, null: false

      t.timestamps
    end
  end
end
