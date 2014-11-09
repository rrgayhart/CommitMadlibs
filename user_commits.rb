require 'faraday'
require 'json'

class UserCommits
  def initialize(username)
    @username = username
  end

  def github_url
    "https://api.github.com/users/#{@username}/events"
  end

  def fetch_commits
    data = get_api_data
    push_event_data = grab_push_events(data)
    payload_data = collect_payloads(push_event_data)
    commit_history = collect_commit_history(payload_data)
    collect_messages(commit_history)
  end

private

  def collect_messages(data)
    data.map do |commit|
      commit['message']
    end
  end

  def collect_commit_history(data)
    data.collect do |payload|
      payload['commits'].collect { |commit| commit }
    end.flatten
  end

  def collect_payloads(data)
    data.collect do |push_event|
      push_event['payload']
    end
  end

  def grab_push_events(data)
    data.select do |event|
      event['type'] == 'PushEvent'
    end
  end

  def get_api_data
    response = Faraday.get(github_url)
    JSON.parse(response.body)
  end
end
