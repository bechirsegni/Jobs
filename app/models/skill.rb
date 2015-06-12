class Skill < ActiveRecord::Base
  has_many :skillings
  has_many :resumes, through: :skillings
end
