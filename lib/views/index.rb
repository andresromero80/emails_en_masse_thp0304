require "pry"
require 'json'
require 'csv'
$:.unshift File.expand_path("./../../app/", __FILE__)
require 'townhalls_adder_to_db.rb'
require 'townhalls_mailer.rb'
require 'townhalls_scrapper.rb'
require 'townhalls_follower.rb'

class Index
	attr_accessor :db_manager, :twitter_manager, :mailer_manager, :scrapping_manager

	def initialize
		@db_manager = DBManager.new
		@twitter_manager = FollowerManager.new
		@mailer_manager = MailerManager.new
		@scrapping_manager = ScrappingManager.new
	end

	def start
		while 1
			system "clear" or system "cls"
			puts "Welcome in our google-agent program."
			puts "Feel free to contact us at thp-google-agent.fr for any suggestion !"
			puts "\n"
			puts "You can use it for multiple purpose :"
			puts "	Press 1	to scrap"
			puts "	Press 2	to use Twitter bot"
			puts "	Press 3	to send emails."
			puts "	Press 4 to exit programm"
			puts "\n"
			puts "Select an option :"

			while 1
				choice = gets.chomp
				break if /\d/.match?(choice) && choice.to_i.between?(1, 5)
				puts "Bad option, select again."
			end

			call_scrapper if choice.to_i == 1
			call_twitter_manager if choice.to_i == 2
			call_mailer if choice.to_i == 3
			quit if choice.to_i == 4
		end

	end

	def quit
		done = Done.new
		done.end
	end

	def call_twitter_manager
		while 1
			system "clear" or system "cls"
			puts "You are using the Twitter bot."
			puts "Please select an option:"
			puts "\n"
			puts "	Press 1 to get twitter accounts from a csv file"
			puts "	Press 2 to follow twitter accounts stored into our csv file."
			puts "	Press 3 to come back into main menu"

			while 1
				choice = gets.chomp
				break if /\d/.match?(choice) && choice.to_i.between?(1, 3)
				puts "Bad option, select again."
			end

			if choice.to_i == 1
				emails = @db_manager.get_city_names
				data = @twitter_manager.push_json(emails)
				@db_manager.write_twitter_handle(data)

				return false
			end

			if choice.to_i == 2
				@twitter_manager.follow_handles
				
				return false
			end
			return false if choice.to_i == 3
		end
	end

	def call_mailer
		array_mails = @db_manager.get_emails
		@mailer_manager.envoi_mail(array_mails)
	end

	def call_scrapper
		urls_to_scrap = [
											#Scrapping du département de la Manche
					            # "http://www.annuaire-des-mairies.com/manche.html",
					            "http://www.annuaire-des-mairies.com/manche-2.html",
					            "http://www.annuaire-des-mairies.com/manche-3.html",
					            # #Scrapping du département de la Vienne
					            "http://www.annuaire-des-mairies.com/vienne.html",
					            #Scrapping du département de l'Ille-et-Vilaine
					            "http://www.annuaire-des-mairies.com/ille-et-vilaine.html",
					            # "http://www.annuaire-des-mairies.com/ille-et-vilaine-2.html"
					        ]
    urls_to_scrap.each do | url |
    	data = @scrapping_manager.run(url)
    	puts "Enregistrement des données en provenance de #{url}."
    	sleep(2)
			@db_manager.write(data)
		end
	end
end