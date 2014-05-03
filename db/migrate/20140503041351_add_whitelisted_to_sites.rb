class AddWhitelistedToSites < ActiveRecord::Migration
  def change
    add_column :sites, :whitelisted, :boolean
  end
end
