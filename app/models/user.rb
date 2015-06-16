class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable


  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "geek.jpg", dependent: :destroy
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/, dependent: :destroy


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.photo = auth.info.image
      user.password = Devise.friendly_token[0,20]
    end
  end
  validates :email, :uniqueness => :true

  has_many :jobs , dependent: :destroy
  has_many :resumes , dependent: :destroy
  has_many :blogs , dependent: :destroy
  has_many :companies , dependent: :destroy

end
