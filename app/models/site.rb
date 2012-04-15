require 'open-uri'
require 'rubygems'
require 'nokogiri'

#html = Nokogiri::HTML(open(an_url).read)
# This would search for any images inside a paragraph (XPath)
#html.xpath('/html/body//p//img')
# This would search for any images with the class "test" (CSS selector)
#html.css('img.test')

class Site < ActiveRecord::Base
  attr_accessible :domain, :ingredient_selector, :method_selector, :title_selector

  def self.add_recipe(url='')
    domain = URI.parse(url).host
    site = Site.find_by_domain domain
    unless site.nil?
      html = Nokogiri::HTML(open(url).read)
      title = html.css(site.title_selector).text.strip
      instructions = html.css(site.method_selector).children.inject(''){|sum, n| sum + n.text + "\n"}
      ingredients = html.css(site.ingredient_selector).children.inject(''){|sum, n| sum + n.text + "\n"}


      recipe = Recipe.new
      recipe.name = title
      recipe.num_people = 4
      recipe.save

      Ingredient.multi_save(ingredients, recipe)
      Instruction.multi_save(instructions, recipe)
      recipe
    else
      false
    end
  end
end
