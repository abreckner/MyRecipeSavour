require 'spec_helper'

describe Ingredient do
  it "should generate new ingredients from a string" do
    recipe = Recipe.make
    ingredients = "Water\nSalt"
    Ingredient.multi_save(ingredients, recipe)
    recipe.ingredients.length.should == 2
    recipe.ingredients.map{|n| n.content}.should include 'Water'
  end

  it "should return content when you request formatted content" do
    ingredient = Ingredient.make
    ingredient.formatted_content.should == 'Water'
  end
end