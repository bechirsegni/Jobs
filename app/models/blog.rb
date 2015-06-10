class Blog < ActiveRecord::Base
  searchkick autocomplete: ['title']
  belongs_to :user
end
