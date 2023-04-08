module SlackCommandsHelper
    # Define a method to open the modal
 def open_new_incident_modal(trigger_id)
    user_id = params['user_id']
    client = Slack::Web::Client.new(token: get_user_token(user_id))

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
end
