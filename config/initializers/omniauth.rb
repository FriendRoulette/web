OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
<<<<<<< HEAD
  provider :facebook, '541756572610649', '84742819c9b850eb9173e5f80b0367b8', {scope: 'id, name, email, user_birthday, gender, read_friendlists '}
=======
  provider :facebook, '229792727217503', 'cecb734ba75df3528ce5d3dd60e7f3ba', {scope: 'basic_info, email, read_stream, read_friendlists, user_birthday, friends_likes, friends_status, offline_access'}
>>>>>>> 230742eae2e16a755c73081f990028975e4ac582
end
