require 'faraday'
require 'json'

class UserCommits
  attr_reader :username, :event_history, :messages

  def initialize(username)
    @username = username
    @event_history = get_event_array
    @messages = give_me_messages
  end

  def give_me_messages
    pull_commits.map do |commit|
      commit['message']
    end
  end

  def event_link
    "https://api.github.com/users/#{username}/events"
  end

  def get_event_array
    response = Faraday.get(event_link)
    JSON.parse(response.body)
  end

  def pull_push_events
    event_history.select do |event|
      event["type"] == 'PushEvent'
    end
  end

  def pull_payload
    pull_push_events.collect do |push_event|
      push_event['payload']
    end
  end

  def pull_commits
    commits = []
    pull_payload.each do |payload|
      payload['commits'].each do |commit|
        commits.push(commit)
      end
    end
    commits
  end

end
