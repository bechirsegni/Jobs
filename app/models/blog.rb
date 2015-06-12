class Blog < ActiveRecord::Base
  searchkick
  belongs_to :user , dependent: :destroy
end
