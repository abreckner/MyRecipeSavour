require 'spec_helper'

describe RecipesHelper do
  it "should link tags" do
    recipe = Recipe.make
    recipe.tag_list = "tag1, tag2, tag3"
    recipe.save
    helper.link_tags(recipe.tags).should == "<a href=\"/recipes?tag=tag3\">tag3</a>, <a href=\"/recipes?tag=tag2\">tag2</a>, <a href=\"/recipes?tag=tag1\">tag1</a>"
  end
end
