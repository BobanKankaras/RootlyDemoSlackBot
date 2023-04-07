# Load the Rails application.
require_relative "application"

Rails.application.configure do
    # config.hosts << /[a-z0-9-.]+\.ngrok\.io/
    config.hosts << "rootly-demo-incident.onrender.com"
    # puts config.hosts
  end

# Initialize the Rails application.
Rails.application.initialize!
