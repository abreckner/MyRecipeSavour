require 'spec_helper'

describe "sites/new" do
  before(:each) do
    assign(:site, stub_model(Site,
      :domain => "MyString",
      :title_selector => "MyString",
      :method_selector => "MyString",
      :ingredient_selector => "MyString"
    ).as_new_record)
  end

  it "renders new site form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sites_path, :method => "post" do
      assert_select "input#site_domain", :name => "site[domain]"
      assert_select "input#site_title_selector", :name => "site[title_selector]"
      assert_select "input#site_method_selector", :name => "site[method_selector]"
      assert_select "input#site_ingredient_selector", :name => "site[ingredient_selector]"
    end
  end
end
