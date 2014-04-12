OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '541756572610649', '84742819c9b850eb9173e5f80b0367b8', {scope: 'id, name, email, user_birthday, gender, read_friendlists '}
end
