class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :authentications, :dependent => :delete_all
  has_and_belongs_to_many(:friends,
                          class_name: 'User',
                          join_table: 'friendship_connections',
                          foreign_key: "user_a_id",
                          association_foreign_key: "user_b_id")

  def self.find_by_token(token)
    User.where(oauth_token: token).first
  end

  def self.data_from_omniauth(auth)
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
      connections = self.graph.get_connections("me", "friends")

      self.update_attribute(:password, 'asskon123')
      self.save

      connections.each do |connection|
        user_for_uuid = User.where(uid: connection['id']).first

        unless user_for_uuid.nil?
          self.friends << user_for_uuid
          user_for_uuid.friends << self

          self.save(:validate => false)
          user_for_uuid.save(:validate => false)
        end
      end
  end

  def load_name
    self.update_attribute(:name, graph.get_object("me")["name"])
  end

  def graph
    Koala::Facebook::API.new(self.oauth_token)
  end

  def firebase
    Firebase::Client.new "https://friendroulette.firebaseio.com/"
  end

  def matchmake
    self.firebase.set("#{self.uid}", 'null')
    found = false

    current_users = $redis.sort('matchmaking-users')

    current_users.each do |id|
      user = User.where(uid: id).first

      if user == self
        next
      end

      if user.nil?
        $redis.lrem('matchmaking-users', 0, id)
        next
      end

      if self.friends.include? user
        random_token = SecureRandom.urlsafe_base64(10)

        self.firebase.set("#{self.uid}", random_token)
        user.firebase.set("#{user.uid}", random_token)

        $redis.lrem('matchmaking-users', 0, user.uid)

        found = true
        break
      end
    end

    if !found
      $redis.rpush('matchmaking-users', self.uid)
    end 
  end
end
