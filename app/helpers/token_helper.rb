module TokenHelper

    def save_token(user_id, user_token, user_refresh_token)
        user = User.where(user_id: user_id).first
        if user.nil?
            user = User.new
            user.user_id = user_id
            user.token = user_token
            user.refresh_token = user_refresh_token
            user.save
        else
            user.token = user_token
            user.save
        end
    end

    def get_user_token(user_id)
        all_user = User.all
        user = User.where(user_id: user_id).first
        if user.nil?
            puts 'User token is nil so returning ENV bot token'
            return ENV['SLACK_BOT_TOKEN']
        else
            begin
                client = Slack::Web::Client.new(token: user.token)
                auth_test_response = client.auth_test
                puts 'auth_test_response: ' + auth_test_response.to_s
                puts 'User token is not expired so returning user token'
                return user.token
            rescue => exception
                puts 'Exception: ' + exception.to_s
                puts 'User token is expired so getting new bot token'
                return get_new_bot_token(user.refresh_token)
            end
            puts 'User token is not nil so returning user token'
            return user.token
        end
    end

    def get_new_bot_token(refresh_token)
        client = Slack::Web::Client.new(token: '')
        response = client.oauth_v2_access(
            client_id: ENV['SLACK_CLIENT_ID'],
            client_secret: ENV['SLACK_CLIENT_SECRET'],
            refresh_token: refresh_token
        )
        return response['access_token']
    end
end
