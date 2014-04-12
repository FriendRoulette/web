OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Settings.apis.facebook.api_key, Settings.apis.facebook.api_secret, {scope: 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
end
