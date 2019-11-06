class CreatePlaceImages < ActiveRecord::Migration[5.2]
  def change
    create_table :place_images do |t|
      t.string :link
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
