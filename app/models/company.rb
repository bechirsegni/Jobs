class Company < ActiveRecord::Base
  belongs_to :user, :foreign_key => "user_id"
  has_many :jobs
end
