require 'slack-ruby-client'

Slack.configure do |config|
    # for OPT testing
    config.token = "xoxe.xoxb-1-MS0yLTQyNjc3NzE1NDYzMzctNTA2OTQyMDMwOTYzNS01MDc5MjM4MjY2ODgyLTUwODE3MTE2NTAyOTItMjUyYzJiMjhjYjVjM2QwNTlhZmQ3ZjRhNTA4MzBlMGQ5ODljMTZmODY5MmE5ODk3MTAyMjIyZmY2NjU0NGI2Yg"

    # for local testing
    # config.token = "xoxb-4267771546337-5079291343138-eWCVJbzikXPzljR6t3zilRxz"
    
    # config.token ||= ENV['SLACK_BOT_TOKEN']
end