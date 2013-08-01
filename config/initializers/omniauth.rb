Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook,
    Settings.facebook.id,
    Settings.facebook.secret

end
