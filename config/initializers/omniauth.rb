OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '229792727217503', 'eca953142e00aa1b538e59739805e131', {scope: 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
end
