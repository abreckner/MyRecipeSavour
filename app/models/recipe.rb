class Recipe < ActiveRecord::Base
  acts_as_taggable
  attr_accessible :name, :num_people, :description, :tag_list
  has_many :equipments
  has_many :ingredients
  has_many :instructions
  belongs_to :user

  validates :num_people, :numericality => { :only_integer => true }, :allow_blank => true
  validates :name, :presence => true
end
