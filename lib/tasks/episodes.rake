require 'rest-client'
require 'mechanize'
require 'nokogiri'
require 'csv'
require 'open-uri'

# constants
URL_TVDB = "http://thetvdb.com/?tab=seasonall&id=110381&lid=7"
API_KEY = "****  REMOVED  ****"
SERIES_ID = "110381"
XML_PATH = "http://thetvdb.com/api/#{API_KEY}/series/#{SERIES_ID}/all/en.xml" # http://thetvdb.com/api/7AB64D5A508BD32F/series/110381/all/en.xml
XML_FILE = "#{Rails.root}/db/data/series_data.xml"
CSV_FILE = "#{Rails.root}/db/data/series_data.csv"

namespace :get do

	desc "Get season data from TVDB"
	task :tvdb_data => :environment do

		# Begin/Rescue: fail count 
		count = 0 

		begin
			xml = Nokogiri::XML(open(XML_PATH))

			File.open(XML_FILE, "w") do |f|
				f.write xml.to_xml
			end

		rescue StandardError => e
			count += 1
			puts "--------------------------------------------"
			puts "Fail Number: #{count} "
			puts "Fail Reason: #{e}"

		end

	end

	desc "Parse xml and add episodes to database"
	task :parsed_xml => :environment do

		# Begin/Rescue: fail count 
		parse_count = 0 

		begin

			f = File.open(XML_FILE)
			doc = Nokogiri::XML(f)
			episodes = doc.xpath("//Episode")

			puts "There are currently #{episodes.size} episodes"

			ep_nodes = episodes.map do |ep|
				episode_skeleton = {}
				episode_skeleton[:ep_number] = ep.xpath("EpisodeNumber").inner_text
				episode_skeleton[:season] = ep.xpath("SeasonNumber").inner_text
				episode_skeleton[:title] = ep.xpath("EpisodeName").inner_text
				episode_skeleton[:summary] = ep.xpath("Overview").inner_text

				if episode_skeleton[:season].to_i < 1
					episode_skeleton[:flag] = true
				else
					episode_skeleton[:flag] = false
				end

				episode_skeleton
			end

			seasons = ep_nodes.group_by{ |i| "#{i['season']}".to_sym }

			@arrSeasons = []

			seasons.each do |key, group|
				group.sort!{ |a,b| "#{a['ep_number']}".to_sym <=> "#{b['ep_number']}".to_sym }.each do |item|
					@arrSeasons << item
				end
			end

			

		rescue StandardError => e

			parse_count += 1
			puts "--------------------------------------------"
			puts "Fail Number: #{parse_count} "
			puts "Fail Reason: #{e}"

		end

		f.close
	end

	desc "Parse xml and add episodes to database"
	task :converted_csv => [ :parsed_xml, :environment] do
		#puts @arrSeasons.size

		sep_seasons = @arrSeasons.group_by{ |i| "#{i['season']}".to_sym }

		@arrSeasons.each do |item|
			puts "season_#{item[:season]}".to_sym
		end

		# (0..5).each do |num|
		# 	csv_file = "#{Rails.root}/db/data/season_#{num}.csv"
		# 	CSV.open(csv_file, "wb") do |csv|
		# 		csv << @arrSeasons.first.keys

		# 		@arrSeasons.each do |hsh|
		# 			csv << hsh.values
		# 		end
		# 	end
		# end
		
	end

end