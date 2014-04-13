class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :authentications, :dependent => :delete_all

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
     user.provider = auth.provider
     user.uid = auth.uid
     user.name = auth.info.name
     user.oauth_token = auth.credentials.token
     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
     user.save!
   end
  end

  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    self.email = auth['extra']['raw_info']['email']
    # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
    authentications << Authentication.new(:user_id => self.id, :provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  
    authentication = authentications.first

    self.provider = authentication.provider
    self.uid = authentication.uid
    self.oauth_token = authentication.token
  end

  def load_friends
  end

  def graph
    Koala::Facebook::API.new(self.oauth_token)
  end
end
