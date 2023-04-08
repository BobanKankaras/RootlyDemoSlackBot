
class AuthController < ApplicationController
    include TokenHelper

    def finish_auth
      client = Slack::Web::Client.new(token: '')
      auth_code = params['code']
      received_state = params['state']

      if received_state == ""

        # Request the auth tokens from Slack
        response = client.oauth_v2_access(
          client_id: ENV['SLACK_CLIENT_ID'],
          client_secret: ENV['SLACK_CLIENT_SECRET'],
          code: auth_code
        )

        ENV['SLACK_BOT_TOKEN'] = response['access_token']

        user_id = response['authed_user']['id']
        user_token = response['access_token']
        save_token(user_id, user_token)
      end
      redirect_to root_path
    end
        
  end
  