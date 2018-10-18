class DBManager
	attr_accessor :session, :spreadsheet

	def initialize
		@session = GoogleDrive::Session.from_config("./config.json")
	end

	def get_session
		return @session
	end

	def get_spreadsheet
		# if get_session.spreadsheet_by_title("thp-google-agent")
			@spreadsheet = get_session.spreadsheet_by_title("thp-google-agent")
		# else
		# 	@spreadsheet = get_session.create_spreadsheet("thp-google-agent", {})
		# end

		return @spreadsheet
	end

	def get_worksheet
		# begin
			ws = get_spreadsheet.worksheet_by_title("thp-google-agent")
		# rescue StandardError => e
		# 	ws = @spreadsheet.add_worksheet("thp-google-agent", 2000, 4)
		# 	ws[1,1] = "nom_ville"
		# 	ws[1,2] = "email"
		# 	ws[1,3] = "departement"
		# 	ws[1,4] = "twitter_handle"
		# end

		return ws
	end

	def write(data)

	ws = get_worksheet
		for i in (0...data.size)
			for j in (0...data[i].size)
				ws[i+2, j+1] = data[i][j]
			end
		end

		ws.save
		export_as("csv", "./db/#{@spreadsheet.title}.csv")
	end

	def get_city_names
		return get_data_from_spreadsheet(0)
	end

	def get_emails
		return get_data_from_spreadsheet(1)
	end

	def get_data_from_spreadsheet(column)
		data = []
		File.open("./db/thp-google-agent.csv", "r") do |f|
			f.each_line.with_index do |line, index|
				unless index == 0
					data << line.split(',')[column]
				end
			end
		end

		puts data
	end

	def export_as(export_format, path)
		get_worksheet.export_as_file(path)
	end

	def csv_to_json(data)
		 json = CSV.parse(data).to_json
		 puts json
	end

	def load_data_for_twitter_bot
		data = get_worksheet
	end
end