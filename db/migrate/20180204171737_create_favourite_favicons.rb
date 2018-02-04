class CreateFavouriteFavicons < ActiveRecord::Migration[5.1]
  def change
    create_table :favourite_favicons do |t|
      t.string :image
      t.string :domain

      t.timestamps
    end
    add_index :favourite_favicons, :domain, unique: true
  end
end
