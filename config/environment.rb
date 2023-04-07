# Load the Rails application.
require_relative "application"

Rails.application.configure do
    # config.hosts << /[a-z0-9-.]+\.ngrok\.io/
    # puts config.hosts
  end

# Initialize the Rails application.
Rails.application.initialize!
