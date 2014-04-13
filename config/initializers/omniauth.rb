OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], {scope: 'basic_info, email, read_stream, read_friendlists, user_birthday, friends_likes, friends_status, offline_access'}
end
