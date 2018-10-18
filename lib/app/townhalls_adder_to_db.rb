class DBManager
	attr_accessor :session

	def initialize
		@session = GoogleDrive::Session.from_config("./config.json")
	end

	def get_session
		return @session
	end
end