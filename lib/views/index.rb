require "pry"
require 'json'
require 'csv'


$:.unshift File.expand_path("./../../app/", __FILE__)
require 'townhalls_adder_to_db.rb'
require 'townhalls_scrapper.rb'

class Index
	attr_accessor :db_manager, :follower_manager, :mailer_manager, :scrapping_manager

	def initialize()
		# @db_manager = DBManager.new
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

	end

	def call_db
		@db_manager.write([["test", "hello", "world"], ["test", "hello", "world"], ["test", "hello", "world"]])
		@db_manager.csv_to_json(@db_manager.spreadsheet)
	end

	def call_follower

	end

	def call_mailer

	end

	def call_scrapper
		print @scrapping_manager.run
	end
end

# binding.pry