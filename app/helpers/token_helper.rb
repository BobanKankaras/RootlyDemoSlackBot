module TokenHelper

    def save_token(user_id, user_token)
        user = User.where(user_id: user_id).first
        if user.nil?
            user = User.new
            user.user_id = user_id
            user.token = user_token
            user.save
        else
            user.token = user_token
            user.save
        end
    end

    def get_user_token(user_id)
        all_user = User.all
        user = User.where(user_id: user_id).first
        puts 'All users: ' + all_user.to_s
        puts 'User: ' + user.to_s
        if user.nil?
            puts 'User token is nil so returning ENV bot token'
            return ENV['SLACK_BOT_TOKEN']
        else
            puts 'User token is not nil so returning user token'
            return user.token
        end
    end
    
end
