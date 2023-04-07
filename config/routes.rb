Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post "api/slack/command", to: "slack_commands#slash_command"
  post "api/slack/action", to: "slack_commands#view_submission"
  # mount Api => '/'
  # Defines the root path route ("/")
  # root "pages#index"
  get '/incidents', to: 'pages#index'
  root to: "pages#index"
end
