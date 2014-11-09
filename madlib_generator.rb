require_relative 'user_commits'
require 'pry'

class MadlibGenerator

  def initialize(username)
    @username = username
  end

  def print_messages
    messages = convert_commits
    puts "\n"
    puts "#{username.capitalize}'s Commit Messages"
    puts '-' * 50
    new_messages = messages.join("\n\n")
    puts new_messages
    puts "\n"
  end

  private

  attr_reader :username

  def convert_commits
    data = plain_messages.collect do |message|
      word_array = message.downcase.split
      replace_nouns_and_verbs(word_array)
    end
  end

  def replace_nouns_and_verbs(word_array)
    word_array.collect do |word|
      if convertable_nouns.include?(word)
        word = replacement_nouns.sample
      elsif convertable_verbs.include?(word)
        word = replacement_verbs.sample
      end
      word
    end.join(' ')
  end

  def plain_messages
    UserCommits.new(username).fetch_commits
  end

  def convertable_nouns
    [
      "assignment",
      "version",
      "html",
      "css",
      "builds",
      "code",
      "commit",
      "merge",
      "username",
      "test",
      "file",
      "form",
      "page",
      "function",
      "readme"
    ]
  end

  def replacement_nouns
    [
      "butt",
      "hard boiled eggs",
      "The Doctor",
      "puppy",
      "bacon",
      "bagpipe",
      "kitten",
      "Beyonce and Jay-Z",
      "soccer moms",
      "Tinder dates"
    ]
  end

  def replacement_verbs
    [
      "curses heavily at",
      "confesses to",
      "sobbing uncontrollably",
      "remembers fondly",
      "putting a ring on it",
      "tickles",
      "singing passionate karaoke",
      "epically battles",
      "emasculates",
      "spoons with"
    ]
  end


  def convertable_verbs
    [
      "fixes",
      "fixed",
      "fixing",
      "create",
      "updated",
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
      "deletes",
      "merge"
    ]
  end

end

username = 'idlehands'
#username = 'rrgayhart'
MadlibGenerator.new(username).print_messages


