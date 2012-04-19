require 'open-uri'
require 'rubygems'
require 'nokogiri'

#html = Nokogiri::HTML(open(an_url).read)
# This would search for any images inside a paragraph (XPath)
#html.xpath('/html/body//p//img')
# This would search for any images with the class "test" (CSS selector)
#html.css('img.test')

class Site < ActiveRecord::Base
  attr_accessible :domain, :ingredient_selector, :method_selector, :title_selector, :url, :user
  belongs_to :user
  before_save :parse_domain

  scope :cataloged, where("title_selector IS NOT NULL and method_selector is NOT NULL and ingredient_selector IS NOT NULL and title_selector <> '' and method_selector <> '' and ingredient_selector <> ''")

  def self.add_recipe(url='', current_user)
    site_domain = URI.parse(url).host
    site = Site.find_by_domain site_domain
    if site.nil?
      site = Site.new
      site.domain = site_domain
      site.url = url
      site.user = current_user
      site.save!
      false
    else
      if site.parseable?
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

  def parseable?
    !self.title_selector.blank? && !self.method_selector.blank? && !self.ingredient_selector.blank?
  end

  private
  def parse_domain
    pure_domain = URI.parse(self.domain).host
    unless pure_domain.nil?
      self.domain = pure_domain
    end
  end

end
