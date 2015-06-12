class Company < ActiveRecord::Base
  belongs_to :user , dependent: :destroy
  has_many :jobs , dependent: :destroy

end
