# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  #:user_name => ENV['SENDGRID_USERNAME'],
  :user_name => 'jtsm1th01',
  #:password => ENV['SENDGRID_PASSWORD'],
  :password => 'ebl0ckxt0l',
  :domain => 'example.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}