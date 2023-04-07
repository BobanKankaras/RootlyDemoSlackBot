SlackRubyBotServer::Events.configure do |config|
  config.signing_secret ||= ENV['SLACK_SIGNING_SECRET']
  config.signature_expires_in ||= 300
  # puts config.signing_secret
end
