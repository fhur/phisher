class AddBlacklistedToSites < ActiveRecord::Migration
  def change
    add_column :sites, :blacklisted, :boolean
  end
end
