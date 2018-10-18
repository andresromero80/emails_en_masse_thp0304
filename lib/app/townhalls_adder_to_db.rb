class DBManager
	attr_accessor :session, :spreadsheet

	def initialize
		@session = GoogleDrive::Session.from_config("./config.json")
		get_spreadsheet
	end

	def get_session
		return @session
	end

	def get_spreadsheet

		if get_session.spreadsheet_by_title("thp-google-agent")
			spreadsheet = get_session.spreadsheet_by_title("thp-google-agent")
		else
			spreadsheet = get_session.create_spreadsheet("thp-google-agent", {})
		end

		@spreadsheet = spreadsheet
	end

	def get_worksheet
		return @spreadsheet.worksheet_by_title("thp-google-agent")
	end

	def write(data)
		column = 1
		data.each do | element |
			write_data_to_spreadsheet(element, column)
			column += 1
		end
		export_as("csv", "./db/#{@spreadsheet.title}.csv")
	end

	def write_data_to_spreadsheet(data, column)
		ws = get_worksheet
		my_index = 2

		data.each do | element|
			ws[my_index, column] = element
			my_index +=1
		end
		ws.save
	end

	def get_data_from_spreadsheet
		return data
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