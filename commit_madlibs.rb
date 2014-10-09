#!/usr/bin/env ruby

require_relative 'user_commits'

class CommitMadlibs

  def initialize(username)
    @username = username
  end

  def print_messages
    messages = fetch_and_convert_commits
    puts "#{username.capitalize}'s Commit Messages"
    puts '-' * 50
    puts messages
  end

  private

  attr_reader :username

  def fetch_and_convert_commits
    plain_messages = UserCommits.new(username).fetch_commits
    convert_messages(plain_messages)
  end

  def convert_messages(plain_messages)
    plain_messages.collect do |message|
      word_array = message.downcase.split
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

username = ' rrgayhart '
CommitMadlibs.new(username).print_messages


