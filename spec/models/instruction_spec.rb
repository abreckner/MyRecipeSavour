require 'spec_helper'

describe Instruction do
  it "should generate new instructions from a string" do
    recipe = Recipe.make
    instructions = "Step 1\nStep 2"
    Instruction.multi_save(instructions, recipe)
    recipe.instructions.length.should == 2
    recipe.instructions.map{|n| n.content}.should include 'Step 1'
  end

  it "should parse the amounts from the instructions" do
    recipe = Recipe.make
    instructions = "Step 1 | 5 minutes\nStep 2 | 10 minutes"
    Instruction.multi_save(instructions, recipe)
    recipe.instructions.length.should == 2
    recipe.instructions.map{|n| n.content}.should include 'Step 1'
    recipe.instructions.map{|n| n.length_in_minutes}.should include 10
  end

  it "should return formatted content" do
    instruction = Instruction.make
    instruction.formatted_content.should == "Place egg in boiling water | 5 minute(s)"
  end

  it "should content if there is no length_in_minutes" do
    instruction = Instruction.make(:length_in_minutes => nil)
    instruction.formatted_content.should == "Place egg in boiling water"
  end
end