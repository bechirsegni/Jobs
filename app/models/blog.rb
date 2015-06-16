class Blog < ActiveRecord::Base
  belongs_to :user
  has_attached_file :photo, :styles => { :medium => "780x517>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  def to_param
    "#{id} #{title}".parameterize
  end

end
