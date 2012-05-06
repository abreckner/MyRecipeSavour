class UpdateContentToTextForIngredients < ActiveRecord::Migration
  def change
    change_column :ingredients, :content, :text
  end
end
