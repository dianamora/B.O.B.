class AddWebsiteToBreweries < ActiveRecord::Migration[6.1]
  def change
    add_column :breweries, :website, :string
  end
end
