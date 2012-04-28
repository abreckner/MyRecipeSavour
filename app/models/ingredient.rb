class Ingredient < ActiveRecord::Base
  attr_accessible :content, :amount
  belongs_to :recipe

  def self.multi_save(ingredients = '', recipe)
    lines = ingredients.split(/\r\n|\n|\r/)
    lines.each do |line|
      ing = self.new(:content => line.strip) if line.strip.length > 0
      recipe.ingredients << ing unless ing.nil?
      recipe.save
    end
  end

  def formatted_content
    content
  end
end
