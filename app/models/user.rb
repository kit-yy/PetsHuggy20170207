class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable

  has_many :listings
  has_many :reservations
  has_many :reviews


  has_attached_file :image, styles: { medium: "400x400>", thumb: "100x100>" }, default_url: "avatar.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = "http://graph.facebook.com/#{auth.uid}/picture?type=large"
    end
  end
end
