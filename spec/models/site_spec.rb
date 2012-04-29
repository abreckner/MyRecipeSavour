require 'spec_helper'

describe Site do
  context "parseable" do 
    it "should say the site is parseable" do
      site = Site.make
      site.parseable?.should == true
    end

    it "should say the site is not parseable" do
      site = Site.new
      site.parseable?.should == false
    end
  end

  context "add_recipe" do
    before(:each) do
      @user = User.make!
    end
    after(:each) do
      User.destroy_all
    end
    it "should not find the site" do
      result = Site.add_recipe "http://www.sitenotfound.com/recipe/1", @user
      result.should == false
      site = Site.find_by_domain "www.sitenotfound.com"
      site.domain.should ==  "www.sitenotfound.com"
      site.url.should == "http://www.sitenotfound.com/recipe/1"
      site.user_id.should == @user.id
    end

    it "should find a non-parseable site" do
      site = Site.new(:domain => 'www.masterchef.com.au')
      site.save
      site.stub!(:parseable?).and_return false
      result = Site.add_recipe "http://www.masterchef.com.au/recipe/1", @user
      result.should == false
    end

    it "should find the recipe and save it" do
      url = "http://www.taste.com.au/recipe/1"
      site = Site.make!
      FakeWeb.register_uri(:get, url , :body => "<h1>Title Test</h1><ul id='methods'><li>method 1</li><li>method 2</li></ul><ul id='ingredients'><li>ingredient 1</li><li>ingredient 2</li><li>ingredient 3</li></ul>")
      recipe = Site.add_recipe url, @user
      recipe.name.should == "Title Test"
      recipe.instructions.length.should == 2
      recipe.ingredients.length.should == 3
      recipe.url.should == url
    end
  end
  
end
