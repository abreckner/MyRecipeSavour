class Recipe < ActiveRecord::Base
  attr_accessible :name, :num_people, :description
  has_many :equipments
  has_many :ingredients
  has_many :instructions
  belongs_to :user

  validates :num_people, :numericality => true
end
