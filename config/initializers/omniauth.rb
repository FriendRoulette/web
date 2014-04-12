OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '541756572610649', '84742819c9b850eb9173e5f80b0367b8', {scope: 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
end
