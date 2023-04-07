require 'slack-ruby-client'

Slack.configure do |config|
    config.token = "xoxe.xoxb-1-MS0yLTQyNjc3NzE1NDYzMzctNTA2OTQyMDMwOTYzNS01MDcwODc0OTkwODM4LTUwNjI5NDA2NDc0OTUtYjE2MmRiMzM5NTU4YmQ0NzBkYTIyNzgwN2U2NDAyY2I0YjljMWZmMGViNmU4YTIwOGJkOWI5MDAxMzRlY2NhYg"
    # config.token ||= ENV['SLACK_BOT_TOKEN']
    # puts 'Token: ' + config.token
end