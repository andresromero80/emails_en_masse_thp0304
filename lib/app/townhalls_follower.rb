require 'twitter'
require 'dotenv'
require 'json'
Dotenv.load

class FollowerManager

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
    end
  end

  def run(emails)
    push_json(emails)
    followers
  end

  def push_json(emails)
    @mairie = Array.new
    puts emails
    emails.each do |email|
      @client.user_search("mairie #{email}").each do |element|
        @mairie << @client.user(element.id).screen_name
      end
    end
    File.open("mairie.JSON","w") do |f|
      f.write(@mairie.to_json)
    end
  end

  
 def followers
    @mairie.each do |screen_names|
    @client.follow("#{screen_names}")
 end
  end

end

FollowerManager.new


 #Pour prendre les données du JSON
 # file = File.read('./email.JSON')
 # datas = JSON.parse(file)
 # datas.each do |names|
 #   ws [i, 1] = names["name"]
 #   i += 1
 # end
