class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :breweries, :phone_number, :contact
    change_column :breweries, :contact, :string
  end
end
