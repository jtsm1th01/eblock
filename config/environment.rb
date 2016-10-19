# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  #:user_name => ENV['SENDGRID_USERNAME'],
  :user_name => 'jtsmith01',
  #:password => ENV['SENDGRID_PASSWORD'],
  :password => 'Ch1gl1acsd',
  :domain => 'eblock-jtsm1th01.c9users.io',
  :address => 'smtp.sendgrid.net',
  :port => 2525,
  :authentication => :plain,
  :enable_starttls_auto => true
}