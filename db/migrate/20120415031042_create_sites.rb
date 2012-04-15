class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :domain
      t.string :title_selector
      t.string :method_selector
      t.string :ingredient_selector

      t.timestamps
    end
  end
end
