OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Settings.apis.facebook.api_key, Settings.apis.facebook.api_secret, { scope: 'id, name, first_name, last_name, email, gender, age_range, user_birthday, read_friendlists' }
end

