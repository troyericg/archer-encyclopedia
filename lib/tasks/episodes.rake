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
	task :episodes => :environment do

		# Begin/Rescue: fail count 
		parse_count = 0 

		Episode.delete_all

		begin

			f = File.open(XML_FILE)
			doc = Nokogiri::XML(f)
			episodes = doc.xpath("//Episode")

			puts "There are currently #{episodes.size} episodes"

			ep_nodes = episodes.map do |ep|
				episode_skeleton = {}
				episode_skeleton[:number] = ep.xpath("EpisodeNumber").inner_text
				episode_skeleton[:season] = ep.xpath("SeasonNumber").inner_text
				episode_skeleton[:title] = ep.xpath("EpisodeName").inner_text
				episode_skeleton[:summary] = ep.xpath("Overview").inner_text

				if episode_skeleton[:season].to_i < 1
					episode_skeleton[:flag] = true
				else
					episode_skeleton[:flag] = false
				end

				Episode.create(episode_skeleton)
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
	task :xml_test => :environment do

		# f = File.open(XML_FILE)
		# doc = Nokogiri::XML(f)
		# episodes = doc.xpath("//Episode")

		@all_episodes = Episode.all

		@all_episodes.each do |ep|
			puts "Season: #{ep[:season]} ; Episode: #{ep[:number]}"
		end

		# episodes.each do |ep|
		# 	seasn = ep.xpath("SeasonNumber").inner_text.to_i
		# 	num = ep.xpath("EpisodeNumber").inner_text.to_i
		# 	name = ep.xpath("EpisodeName").inner_text

		# 	if (seasn == 1)
		# 		puts name
		# 	end
		# end

	end

end