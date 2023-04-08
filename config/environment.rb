# Load the Rails application.
require_relative "application"

Rails.application.configure do
    # for only local testing  
    # config.hosts << /[a-z0-9-.]+\.ngrok\.io/
    config.hosts << /[a-z0-9\-\.]+\.ngrok\.io/
    config.hosts << /[a-z0-9\-\.]+\.ngrok-free\.app/

    # for only render.com testing
    config.hosts << "rootly-demo-incident.onrender.com"

    # for other testing
    
  end

# Initialize the Rails application.
Rails.application.initialize!
