class AddImageSelectorToSite < ActiveRecord::Migration
  def change
    add_column :sites, :image_selector, :string
  end
end
