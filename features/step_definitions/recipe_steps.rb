When /^I go to the recipes page$/ do
  visit "/recipes"
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content text
end
