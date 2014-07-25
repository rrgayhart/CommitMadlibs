require_relative 'user_commits'

class CommitMadlibs
  attr_reader :plain_messages

  def initialize(username)
    user_events = UserCommits.new(username)
    @plain_messages = user_events.messages
  end

  def convert_messsages
    plain_messages.collect do |message|
      word_array = message.downcase.split(' ')
      word_array.collect do |each_word|
        word = each_word
        if convertable_nouns.include?(word)
          word = replacement_nouns.sample
        elsif convertable_verbs.include?(word)
          word = replacement_verbs.sample
        end
        word
      end.join(' ')
    end
  end

  def convertable_nouns
    [
      "assignment",
      "html",
      "css",
      "commit",
      "merge",
      "username",
      "test",
      "form",
      "page",
      "function",
      "readme"
    ]
  end

  def convertable_verbs
    [
      "fixes",
      "fixed",
      "fixing",
      "completes",
      "completed",
      "completing",
      "adds",
      "added",
      "adding",
      "update",
      "updating",
      "updates",
      "removes",
      "removing",
      "removed",
      "delete",
      "deletes"
    ]
  end

  def replacement_nouns
    [
      "butt",
      "puppy",
      "kitten",
      "soccer moms"
    ]
  end

  def replacement_verbs
    [
      "punches",
      "epically battles",
      "emasculates",
      "spoons with"
    ]
  end
end

username = 'rrgayhart'
madlibs = CommitMadlibs.new(username)
puts username.capitalize + '\'s Commit Messages'
puts '-' * 50
puts madlibs.convert_messsages
