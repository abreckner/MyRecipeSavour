class AddImageToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :image, :string
  end
end
