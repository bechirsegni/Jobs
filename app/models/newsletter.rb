class Newsletter < ActiveRecord::Base
  validates :email,  presence: true
end
