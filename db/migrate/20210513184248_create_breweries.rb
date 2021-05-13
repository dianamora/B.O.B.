class CreateBreweries < ActiveRecord::Migration[6.1]
  def change
    create_table :breweries do |t|
      t.string :name
      t.string :location
      t.time :hours
      t.integer :phone_number
      t.string :img_url

      t.timestamps
    end
  end
end
