Rails.application.routes.draw do
  post "api/slack/command", to: "slack_commands#slash_command"
  post "api/slack/action", to: "slack_actions#view_submission"
  get "api/auth/", to: "auth#finish_auth"

  resources :pages
  root to: "pages#index"
end
