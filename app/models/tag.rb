class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :jobs, through: :taggings
end
