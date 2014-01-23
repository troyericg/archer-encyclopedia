require 'rest-client'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

namespace :get do

	desc "Run the full set of data-operations tasks"
	task :all_data => :environment do


		# list of current 'get' tasks
		tasks_at_hand = ["parsed_xml", "characters", "references"]

		# Loops over and runs all the 'get' tasks
		# to load season and character data into database
		tasks_at_hand.each do |task|
			Rake::Task["get:#{task}"].reenable
			Rake::Task["get:#{task}"].invoke
		end

		# test 
		puts 
		puts "---------------------"
		puts "Step 04: Make a really impressive app with all of this data."
		puts "---------------------"
		puts 
		
	end

end