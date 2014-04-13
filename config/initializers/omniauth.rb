OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '229792727217503', 'cecb734ba75df3528ce5d3dd60e7f3ba', {scope: 'basic_info, email, read_stream, read_friendlists, user_birthday, friends_likes, friends_status, offline_access'}
end
