class Done
	def end
		begin
				system "clear" or system "cls"
				puts "Work is done."
				puts "Thanks you for using this software"
				puts "Please send us any suggestion at thp-google-agent.fr"
				puts "Program will now exit. See you soon !"
				sleep(2)
				exit(true)
			rescue StandardError => e
			  puts e.class
			  puts e.message
			  exit(false)
			end
	end
end