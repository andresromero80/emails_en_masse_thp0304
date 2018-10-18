$:.unshift File.expand_path("./../../app/", __FILE__)
require 'townhalls_adder_to_db.rb'

class Index
	attr_accessor :db_manager, :follower_manager, :mailer_manager, :scrapping_manager

	def initialize()
		@db_manager = DBManager.new
		# @follower_manager = FollowerManager.new
		# @mailer_manager = MailerManager.new
		# @scrapping_manager = ScrappingManager.new
	end

	def start
		puts "Welcome in our google-agent program."
		puts "You can use it for multiple purpose :"
		puts "	To get email addresses from webpages."
		puts "	To store data into spreadsheets."
		puts "	To send emails."
		puts "	To make twitter relaunch."
		puts "Feel free to contact us at thp-google-agent.fr for any suggestion !"
	end

	def call_add_to_db

	end

	def call_follower

	end

	def call_mailer

	end

	def call_scrapper

	end
end