class Skilling < ActiveRecord::Base
  belongs_to :skill
  belongs_to :resume , dependent: :destroy
end