class Blog < ActiveRecord::Base
  searchkick
  belongs_to :user
  has_many :comments
  has_attached_file :photo, :styles => { :medium => "780x517>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
