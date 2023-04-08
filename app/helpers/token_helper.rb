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
        user = User.where(user_id: user_id).first
        if user.nil?
            return user.token
        else
            return ENV['SLACK_BOT_TOKEN']
        end
    end
    
end
