SMTP_SETTINGS = {
  address: "smtp.mandrillapp.com",
  port: 587,
  enable_starttls_auto: true,
  user_name: "jeffsee.55@gmail.com",
  password: ENV["MANDRILL_API_KEY"],
  authentication: "login"
}
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: "utf-8"
