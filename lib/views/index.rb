require "pry"
require 'json'
require 'csv'


$:.unshift File.expand_path("./../../app/", __FILE__)
require 'townhalls_adder_to_db.rb'
require 'townhalls_scrapper.rb'

class Index
	attr_accessor :db_manager, :follower_manager, :mailer_manager, :scrapping_manager

	def initialize()
		@db_manager = DBManager.new
		# @follower_manager = FollowerManager.new
		# @mailer_manager = MailerManager.new
		@scrapping_manager = GetEmails.new
	end

	def start
		puts "Welcome in our google-agent program."
		puts "Feel free to contact us at thp-google-agent.fr for any suggestion !"
		puts "\n"
		puts "You can use it for multiple purpose :"
		puts "	Press 1	to get email addresses from webpages."
		puts "	Press 2	to store data into spreadsheets."
		puts "	Press 3	to send emails."
		puts "	Press 4	to make twitter relaunch."
		puts "Select an option :"

		while 1
			choice = gets.chomp
			break if /\d/.match?(choice) && choice.to_i.between?(1, 4)
			puts "Bad option, select again."
		end

		call_scrapper if choice.to_i == 1
		call_follower if choice.to_i == 2
		call_mailer if choice.to_i == 3

	end

	def call_db
	end

	def call_follower

	end

	def call_mailer

	end

	def call_scrapper
		data = @scrapping_manager.run
		@db_manager = DBManager.new
		@db_manager.write(data)
	end
end

# binding.pry