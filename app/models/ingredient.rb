class Ingredient < ActiveRecord::Base
  attr_accessible :content, :amount
  belongs_to :recipe

  def self.multi_save(ingredients = '', recipe)
    lines = ingredients.split(/\r\n|\n|\r/)
    lines.each do |line|
      if line.include?('|')
        line_items = line.split('|')
        ing = self.new(:amount => line_items[0].strip, :content => line_items[1].strip)
      else
        ing = self.new(:content => line.strip) if line.strip.length > 0
      end
      recipe.ingredients << ing unless ing.nil?
      recipe.save
    end
  end

  def formatted_content
    unless amount.blank?
      amount + " | " + content
    else
      content
    end
  end
end
