class Recipe < ActiveRecord::Base
  acts_as_taggable
  attr_accessible :name, :num_people, :description, :tag_list, :image
  has_many :equipments
  has_many :ingredients
  has_many :instructions
  belongs_to :user

  validates :num_people, :numericality => { :only_integer => true }, :allow_blank => true
  validates :name, :presence => true

  def formatted_instructions
    self.instructions.inject(""){|sum, i| sum + i.formatted_content + "\n"}
  end

  def formatted_ingredients
    self.ingredients.inject(""){|sum, i| sum + i.formatted_content + "\n"}
  end
end
