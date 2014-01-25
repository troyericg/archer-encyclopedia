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
			:category => nil,
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

		# constants
		URL_WIKI = "http://en.wikipedia.org/wiki"
		URL_WIKI_ARCHER = "#{URL_WIKI}/Archer_(TV_series)"
		@all_characters = Character.all
		
		ref_skeleton = {
			:subject => nil,
			:summary => nil,
			:category => nil,
			:image => nil,
			:link => nil,
			:line => nil
		}

		ref_fields = ["character", "reference_subject", "reference_line", "reference_category", "episode_number", "season"]
		
		# translate google doc fields to database fields
		ref_translator = {
			"subject" => "reference_subject",
			"category" => "reference_category",
			"line" => "reference_line"
		}

		# open up csv and set headers to symbols
		c = File.open(CSV_FILE, "r")
		csv = CSV.new(c, :headers => true, :header_converters => :symbol)

		# converts csv into array of hashes
		csv_hsh = csv.to_a.map { |row| row.to_hash }
		
		# cycles through csv/reference data and matches with database object 
		csv_hsh.each do |ref|
			search_term = ref[:character]
			character_model = @all_characters.find(:all, :conditions => ["name like ?", "%#{search_term}%"]).first

			puts "#{character_model[:name]} referenced #{ref[:reference_subject]}, with the line \" #{ref[:reference_line]} \""
		end

		c.close
	end

end