require 'gdata/client'
require 'gdata/http'
require 'gdata/auth'
require 'csv'
require 'nokogiri'

namespace :get do

	CSV_FILE = "#{Rails.root}/db/data/series_data.csv"

	desc "Get references from Google doc"
	task :references => :environment do

		# KEY = "0Ang1OfZPG6vydHVxOFh1RmJKT3dwYlI4Y3BtclE1LVE"
		URL = "https://docs.google.com/feeds/download/spreadsheets"

		sheet_keys = {
			troy: "0Ang1OfZPG6vydHVxOFh1RmJKT3dwYlI4Y3BtclE1LVE"
		}

		ref_skeleton = {
			:subject => nil,
			:summary => nil,
			:image => nil,
			:link => nil,
			:line => nil
		}

		puts "---------------------"
		puts "Step 03: Grab references from Google doc and match with characters/episodes"
		puts "---------------------"
		puts 


		client = GData::Client::Spreadsheets.new
		client.clientlogin('****  REMOVED  ****', '****  REMOVED  ****')

		response = client.get("#{URL}/Export?key=#{sheet_keys[:troy]}&fmcmd&exportFormat=csv")
		
		spreadsheet = CSV.parse(response.body)

		CSV.open(CSV_FILE, "wb") do |csv|
			spreadsheet.drop(1).each do |line|
				csv << line
			end
		end

	end

	desc "Add references to database"
	task :parsed_references => :environment do
		c = File.open(CSV_FILE, "r")
		c.each_line do |lne|
			puts "This: #{lne}"
		end
		c.close
	end

end