module SlackActionsHelper

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

end
