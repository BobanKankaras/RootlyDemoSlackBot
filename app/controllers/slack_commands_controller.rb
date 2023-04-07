require 'slack-ruby-client'

class SlackCommandsController < ApplicationController
    skip_before_action :verify_authenticity_token

    # Check command is declared
    def check_declare_format(str)
        if str.start_with?('declare') && str.length > 'declare'.length
          return str['declare '.length..-1]
        else
          return str
        end
    end

    # Define a method to open the modal
    def open_new_incident_modal(trigger_id)
      client = Slack::Web::Client.new

      view = {
        type: 'modal',
        callback_id: 'create_incident',
        title: {
          type: 'plain_text',
          text: 'Create a New Incident'
        },
        submit: {
          type: 'plain_text',
          text: 'Create'
        },
        close: {
          type: 'plain_text',
          text: 'Cancel'
        },
        blocks: [
          {
            type: 'input',
            element: {
              type: 'plain_text_input',
              action_id: 'incident_title',
              placeholder: {
                type: 'plain_text',
                text: 'customers-001 database down'
              }
            },
            label: {
              type: 'plain_text',
              text: 'Title (optional)'
            }
          },
          {
            type: 'input',
            element: {
              type: 'plain_text_input',
              action_id: 'incident_description',
              placeholder: {
                type: 'plain_text',
                text: 'Briefly describe the impact of the incident'
              }
            },
            label: {
              type: 'plain_text',
              text: 'Summary (optional)'
            }
          },
          {
            type: 'input',
            element: {
              type: 'static_select',
              action_id: 'incident_severity',
              placeholder: {
                type: 'plain_text',
                text: 'Assign'
              },
              options: [
                {
                  text: {
                    type: 'plain_text',
                    text: 'SEV-0'
                  },
                  value: 'SEV-0'
                },
                {
                  text: {
                    type: 'plain_text',
                    text: 'SEV-1'
                  },
                  value: 'SEV-1'
                },
                {
                  text: {
                    type: 'plain_text',
                    text: 'SEV-2'
                  },
                  value: 'SEV-2'
                },
                {
                  text: {
                    type: 'plain_text',
                    text: 'SEV-3'
                  },
                  value: 'SEV-3'
                }
              ]
            },
            label: {
              type: 'plain_text',
              text: 'Severity (optional)'
            }
          }
        ],
      }

      response = client.views_open(
      trigger_id: trigger_id,
      view: view
      )

    end

    # Create incident
    def create_incident(payload, client)
      title ||= payload['view']['state']['values'][payload['view']['blocks'][0]['block_id']]['incident_title']['value']
      description ||= payload['view']['state']['values'][payload['view']['blocks'][1]['block_id']]['incident_description']['value']
      severity ||= payload['view']['state']['values'][payload['view']['blocks'][2]['block_id']]['incident_severity']['selected_option']['text']['text']

      user_name = payload['user']['username']
      user_id = payload['user']['id']
      
      time = Time.now.strftime("%Y%m%d%H%M%S")
      
      response = client.conversations_create(name: 'incident-' + time)
      channel_id = response['channel']['id']
      
      incident = Incident.new(title: title, description: description, severity: severity, created_by: user_name, resolved: 0, channel_id: channel_id);
      incident.save

      if response['ok']
        channel_id = response['channel']['id']
        puts 'user: ' + user_name + ': ' + user_id
        puts 'channel_id: ' + channel_id
        client.conversations_invite(channel: channel_id, users: user_id)
        client.chat_postMessage(channel: channel_id, text: 'New incident created by ' + user_name + ' in channel <#' + channel_id + '>')
        client.chat_postMessage(
          channel: channel_id,
          text: '*Title:* ' + title + '    *Description:* ' + description + '    *Severity:* ' + severity
      )
      
      else
        puts 'error: ' + response['error']
      end

    end

    # Resolve incident
    def resolve_incident(params, client)
      channel_id = params['channel_id']

      incident = Incident.where(channel_id: channel_id).first
      if !incident.nil?
        if incident.resolved == 1
          return 'Incident already resolved in channel <#' + channel_id + '>'
        else
          incident.resolved = 1
          incident.resolved_at = Time.now
          incident.save
        end
        return 'Incident resolved by ' + params['user_name'] + ' in channel <#' + channel_id + '>'
      else
        return 'No incident found for channel <#' + channel_id + '>'
      end

    end

    # Define a method to handle the view submission event
    def view_submission
      # puts params
      payload = JSON.parse(params[:payload])
      client = Slack::Web::Client.new

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

    # Define a method to handle the view closed event
    def slash_command
      client = Slack::Web::Client.new
      command = params[:command]
      text = check_declare_format(params[:text])
      trigger_id = params[:trigger_id]
      user_name = params[:user_name]
      user_id = params[:user_id]
  
      case command
      # Handle the "/rootly" command
      when "/rootly"
        case text
        when 'declare'
            open_new_incident_modal(trigger_id)
        when 'resolve'
            message = resolve_incident(params, client)
        else
            message = "/rootly called but no context for in this case!"
        end

      # /ping testing for local development
      when "/ping"
        case text
        when 'declare'
            open_new_incident_modal(trigger_id)
        when 'resolve'
            message = resolve_incident(params, client)
        else
            message = "/rootly called but no context for in this case!"
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
  