class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  mount_uploader :image, ImageUploader
  has_many :photos


  def self.find_or_create_from_oauth(auth)
    User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.user_name   = auth.info.nickname
      user.avatar_url = auth.info.image
      user.email      = User.dummy_email(auth)
      user.password   = Devise.friendly_token[0, 20]
    end
  end


  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
