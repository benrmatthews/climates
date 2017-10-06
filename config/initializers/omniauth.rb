# -*- encoding : utf-8 -*-
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, AppConfig.google_apps.client_id, AppConfig.google_apps.secret,
    {
      scope: 'userinfo.email,userinfo.profile',
      approval_prompt: "auto",
      access_type: "online",
      hd: AppConfig.google_apps.domain
    }
end
