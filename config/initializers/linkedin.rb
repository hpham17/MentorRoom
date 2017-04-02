LinkedIn.configure do |config|
  config.token = ENV['LINKEDIN_ID']
  config.secret = ENV['LINKEDIN_SECRET']
end
