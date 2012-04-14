class Ingredient < ActiveRecord::Base
  attr_accessible :content, :amount
  belongs_to :recipe

  def self.multi_save(ingredients = '', recipe)
    lines = ingredients.split(/\r\n|\n/)
    lines.each do |line|
      ing = self.new(:content => line)
      recipe.ingredients << ing
      recipe.save
    end
  end
end
