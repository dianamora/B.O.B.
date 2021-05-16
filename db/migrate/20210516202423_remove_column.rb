class RemoveColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :breweries, :location
    remove_column :breweries, :hours
    remove_column :breweries, :website
    remove_column :breweries, :contact
    remove_column :breweries, :img_url
  end
end
