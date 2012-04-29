require 'spec_helper'

describe Recipe do
  it "should return the formatted instructions" do
    recipe = Recipe.make!(:complete)
    recipe.formatted_instructions.should == "Place egg in boiling water\nPlace egg in boiling water\n"
  end

  it "should return content when you request formatted content" do
    recipe = Recipe.make!(:complete)
    recipe.formatted_ingredients.should == "Water\nWater\nWater\n"
  end
end