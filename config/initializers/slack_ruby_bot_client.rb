require 'slack-ruby-client'

Slack.configure do |config|
    config.token = "xoxb-4267771546337-5069420309635-ixzJlECscHwlmLsbSxDV4Idb"
    # config.token ||= ENV['SLACK_BOT_TOKEN']
    # puts 'Token: ' + config.token
end