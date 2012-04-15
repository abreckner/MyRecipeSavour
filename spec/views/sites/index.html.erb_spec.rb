require 'spec_helper'

describe "sites/index" do
  before(:each) do
    assign(:sites, [
      stub_model(Site,
        :domain => "Domain",
        :title_selector => "Title Selector",
        :method_selector => "Method Selector",
        :ingredient_selector => "Ingredient Selector"
      ),
      stub_model(Site,
        :domain => "Domain",
        :title_selector => "Title Selector",
        :method_selector => "Method Selector",
        :ingredient_selector => "Ingredient Selector"
      )
    ])
  end

  it "renders a list of sites" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Domain".to_s, :count => 2
    assert_select "tr>td", :text => "Title Selector".to_s, :count => 2
    assert_select "tr>td", :text => "Method Selector".to_s, :count => 2
    assert_select "tr>td", :text => "Ingredient Selector".to_s, :count => 2
  end
end
