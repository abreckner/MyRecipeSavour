require 'spec_helper'

describe Ingredient do
  it "should generate new ingredients from a string" do
    recipe = Recipe.make
    ingredients = "Water\nSalt"
    Ingredient.multi_save(ingredients, recipe)
    recipe.ingredients.length.should == 2
    recipe.ingredients.map{|n| n.content}.should include 'Water'
  end

  it "should parse the amount from the ingredient item" do
    recipe = Recipe.make
    ingredients = "1 Litre | Water\n 1 teaspoon | Salt\n Fish"
    Ingredient.multi_save(ingredients, recipe)
    recipe.ingredients.length.should == 3
    recipe.ingredients.map{|n| n.content}.should include 'Water'
    recipe.ingredients.map{|n| n.content}.should include 'Fish'
    recipe.ingredients.map{|n| n.amount}.should include '1 Litre'
  end

  it "should return formatted content" do
    ingredient = Ingredient.make
    ingredient.formatted_content.should == '5 litres | Water'
  end

  it "should return content when you request formatted content" do
    ingredient = Ingredient.make(:amount => nil)
    ingredient.formatted_content.should == 'Water'
  end
end