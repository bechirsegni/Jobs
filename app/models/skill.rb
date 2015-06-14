class Skill < ActiveRecord::Base
  has_many :skillings, dependent: :destroy
  has_many :resumes, through: :skillings
end
