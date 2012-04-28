require 'spec_helper'

describe Instruction do
  it "should generate new instructions from a string" do
    recipe = Recipe.make
    instructions = "Step 1\nStep 2"
    Instruction.multi_save(instructions, recipe)
    recipe.instructions.length.should == 2
    recipe.instructions.map{|n| n.content}.should include 'Step 1'
  end

  it "should return content" do
    instruction = Instruction.make
    instruction.formatted_content.should == "Place egg in boiling water"
  end
end