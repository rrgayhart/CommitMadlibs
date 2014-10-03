require 'faraday'
require 'json'

class UserCommits

  def initialize(username)
    @username = username
  end

  def fetch_commits(event_history=nil)
    event_history ||= get_event_history
    push_event_data = pull_push_events(event_history)
    payload_data = pull_payload(push_event_data)
    commit_history = pull_commit_data(payload_data)
    give_me_messages(commit_history)
  end

  private

  def give_me_messages(commit_history)
    commit_history.map do |commit|
      commit['message']
    end
  end

  def event_link
    "https://api.github.com/users/#{username}/events"
  end

  def get_event_history
    response = Faraday.get(event_link)
    JSON.parse(response.body)
  end

  def pull_push_events(event_history)
    event_history.select do |event|
      event["type"] == 'PushEvent'
    end
  end

  def pull_payload(push_events)
    push_events.collect do |push_event|
      push_event['payload']
    end
  end

  def pull_commit_data(pull_payload_data)
    pull_payload_data.collect do |payload|
      payload['commits'].collect { |commit| commit }
    end.flatten
  end

  def username
    @username.strip
  end
end
