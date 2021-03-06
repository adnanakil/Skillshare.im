ActionMailer::Base.smtp_settings = {
  address: "smtp.mandrillapp.com",
  port: 25, # ports 587 and 2525 are also supported with STARTTLS
  enable_starttls_auto: true, # detects and uses STARTTLS
  user_name: ENV["MANDRILL_USER_NAME"],
  password: ENV["MANDRILL_PASSWORD"], # SMTP password is any valid API key
  authentication: "login", # Mandrill supports 'plain' or 'login'
  domain: "skillshare.im", # your domain to identify your server when connecting
}

require 'development_mail_interceptor'
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.staging? || Rails.env.development?

Gibbon::Request.api_key = ENV["MAILCHIMP_API_KEY"]
