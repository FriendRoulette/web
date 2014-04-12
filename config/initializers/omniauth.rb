OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Settings.apis.facebook.api_key, Settings.apis.facebook.api_secret, { scope: Settings.apis.facebook.access_requirements }
end

