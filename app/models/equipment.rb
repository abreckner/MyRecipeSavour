class Equipment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :recipe
end
