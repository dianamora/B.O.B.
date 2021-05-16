class AddYelpIdToBreweries < ActiveRecord::Migration[6.1]
  def change
    add_column :breweries, :yelp_id, :integer
    add_column :breweries, :city, :string
    add_column :breweries, :state, :string
  end
end
