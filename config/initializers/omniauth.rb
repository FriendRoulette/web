OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Settings.apis.facebook.api_key, Settings.apis.facebook.api_secret, { scope: 'id, name, email, gender, user_birthday' }
end

