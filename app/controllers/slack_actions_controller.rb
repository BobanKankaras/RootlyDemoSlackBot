require 'dotenv/load'

class SlackActionsController < ApplicationController
    skip_before_action :verify_authenticity_token
    include TokenHelper, SlackActionsHelper

     # Define a method to handle the view submission event
     def view_submission
        # puts params
        payload = JSON.parse(params[:payload])
  
        puts 'token(view_submission): ' + ENV['SLACK_BOT_TOKEN']
        user_id = payload['user']['id']
        client = Slack::Web::Client.new(token: get_user_token(user_id))
  
        view_id = payload['view']['id'];
  
        client.views_update(
          view_id: view_id,
          view: {
            "type": "modal",
            "title": {
              "type": "plain_text",
              "text": "Submission Successful"
            },
            "close": {
              "type": "plain_text",
              "text": "Close"
            },
            "blocks": [
              {
                "type": "section",
                "text": {
                  "type": "plain_text",
                  "text": "Thank you for your submission!"
                }
              }
            ]
          }
        )
  
        # Call the create_incident method to handle the submission
        create_incident(payload, client)
  
        render json: { ok: true }
      end
  
end