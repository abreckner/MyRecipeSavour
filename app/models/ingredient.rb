class Ingredient < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :recipe
end
