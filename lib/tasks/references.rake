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
		URL_ARCHER_REFS = "http://archer.wikia.com/wiki/References"
		@all_characters = Character.all
		@all_episodes = Episode.all

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

		# FOR TEST: Clear out reference database 
		Reference.delete_all

		@all_characters.each do |char|
			char.references.delete_all
			char.episodes.delete_all
		end

		# cycles through csv/reference data and matches with database object 
		count = 0

		csv_hsh.each do |ref|
			
			begin 
				character_model = @all_characters.where("name like ?", "%#{ref[:character]}%").first
				ep_model = @all_episodes.where("season = ?", "#{ref[:season]}").where( "number = ?", "#{ref[:episode_number]}").first

				puts character_model.class

				ref_skeleton = {}
				ref_skeleton[:line] = ref[:reference_line]
				ref_skeleton[:subject] = ref[:reference_subject]
				ref_skeleton[:category] = ref[:reference_category]

				# TO-DO: Add in :summary, :image, and :link. Populated with wiki data
				ref_model = Reference.find_by(line: ref_skeleton[:line]) || Reference.create(ref_skeleton)

				print <<-LOGLINE;
				In Episode #{ep_model[:number]} - Season #{ep_model[:season]} 
				#{character_model[:name]} referenced #{ref[:reference_subject]}, 
				with the line \"#{ref[:reference_line]}\"
				LOGLINE
				puts 
				puts "---------------------"

				puts character_model.references.count

				# how it goes down 
				# ---------------------
				# push newly-created reference model into matched characer model 
				# character_model.references << ref_model

				# push matched episode model into reference model 
				ref_model.episodes << ep_model

				# finally, push episode model into character model 
				character_model.episodes << ep_model

				puts character_model.references.count

			rescue StandardError => e
				count += 1
				puts "--------------------------------------------"
				puts "Fail Number: #{count} "
				puts "Fail Reason: #{e}"

			end
		end
		c.close

		# ref_m = Reference.first
		# puts ref_m[:subject]
		# puts ref_m[:line]
		# puts ref_m.episodes.first
	end

end