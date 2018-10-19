class DBManager
	attr_accessor :session, :spreadsheet

	def initialize
		@session = GoogleDrive::Session.from_config("./config.json")
	end

	def get_session
		return @session
	end

	def get_spreadsheet
			@spreadsheet = get_session.spreadsheet_by_title("thp-google-agent")
		return @spreadsheet
	end

	def get_worksheet
			ws = get_spreadsheet.worksheet_by_title("thp-google-agent")
		return ws
	end

	def write(data)
		ws = get_worksheet
		start_writing = ws.num_rows + 1
		begin
			for i in (0...data.size)
				for j in (0...data[i].size)
					ws[start_writing + i, j+1] = data[i][j]
				end
			end
			ws.synchronize
			export_as("csv", "./db/#{@spreadsheet.title}.csv")
		rescue StandardError => e
			puts e.class
			puts e.message
		end
	end

	def write_twitter_handle(data)
		ws = get_worksheet

		begin
			for i in (0...data.size)
				ws[i + 2, 4] = data[i]
			end
			ws.synchronize
			export_as("csv", "./db/#{@spreadsheet.title}.csv")
		rescue StandardError => e
			puts e.class
			puts e.message
		end
	end

	def get_city_names
		return get_data_from_spreadsheet(0)
	end

	def get_emails
		return get_data_from_spreadsheet(1)
	end

	def get_data_from_spreadsheet(column)
		data = []

		filename = "thp-google-agent.csv" 
		unless File.file?("./db/#{filename}")
			File.open("./db/#{filename}", "w") do |f|
			end
		end

		File.open("./db/#{filename}", "r") do |f|
			f.each_line.with_index do |line, index|
				unless index == 0
					data << line.split(',')[column]
				end
			end
		end

		return data
	end

	def export_as(export_format, path)
		get_worksheet.export_as_file(path)
	end
end
