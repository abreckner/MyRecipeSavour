require 'spec_helper'

describe "sites/show" do
  before(:each) do
    @site = assign(:site, stub_model(Site,
      :domain => "Domain",
      :title_selector => "Title Selector",
      :method_selector => "Method Selector",
      :ingredient_selector => "Ingredient Selector"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Domain/)
    rendered.should match(/Title Selector/)
    rendered.should match(/Method Selector/)
    rendered.should match(/Ingredient Selector/)
  end
end
