class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.text :name
      t.text :content
      t.text :address
      t.integer :type_id
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
