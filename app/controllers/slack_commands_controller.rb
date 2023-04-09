require 'dotenv/load'

class SlackCommandsController < ApplicationController
    skip_before_action :verify_authenticity_token
    include TokenHelper, ApplicationHelper, SlackCommandsHelper
     
     # Define a method to handle the view closed event
     def slash_command
      user_id = params[:user_id]
      user_token = get_user_token(user_id)
      # puts 'user_token: ' + user_token
      # token = params[:token]
      # puts 'token(slash_command): ' + token

      client = Slack::Web::Client.new(token: user_token)
      command = params[:command]
      text = check_declare_format(params[:text])
      trigger_id = params[:trigger_id]
      user_name = params[:user_name]
      user_id = params[:user_id]

      puts 'user: ' + user_name + ': ' + user_id
  
      case command
      # Handle the "/rootly" command
      when "/rootly"
        case text[0]
        when 'declare'
            open_new_incident_modal(client, trigger_id, text[1])
        when 'resolve'
            message = resolve_incident(params, client)
        else
            message = "/rootly called but no context for in this case!"
        end

      # /ping testing for local development
      when "/ping"
        case text
        when 'declare'
            open_new_incident_modal(client, trigger_id)
        when 'resolve'
            message = resolve_incident(params, client)
        else
            message = "/ping for locally testing is called but no context for in this case!"
        end
      
      else
        message = "Unknown command"
      end
  
      render json: {
        response_type: "in_channel",
        text: message
      }
    end
end
  