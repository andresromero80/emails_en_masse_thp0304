require 'twitter'
require 'dotenv'
require 'json'
Dotenv.load

class FollowerManager
  attr_accessor :handle_twitter

  def initialize
    @handle_twitter = []
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
    end
  end

  def push_json(emails)
    system "clear" or system "cls"
    count = 0
    emails.each do |email|
      if (count % 15 == 0 && count > 0)
        puts ">> Our bot is collecting data >> Progression  >> #{count * 100 / emails.size}%" 
      end

      begin
        @client.user_search("mairie #{email}").each do | element |
          @handle_twitter << element.screen_name
        end
        count += 1
      rescue StandardError => e
        puts e.class
        puts e.message
      end
    end

    return @handle_twitter
  end

 def follow_handles
    @handle_twitter.each do | screen_name |
      begin
        puts "Following #{screen_name}"
        @client.follow("#{screen_name}")
      rescue StandardError => e
        puts e.class
        puts e.message
      end
    end
  end
end