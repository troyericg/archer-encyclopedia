require 'rest-client'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

namespace :get do

	desc "Get references from Google doc"
	task :references => :environment do

		ref_skeleton = {
			:subject => nil,
			:summary => nil,
			:image => nil,
			:link => nil,
			:line => nil
		}

		# test 
		puts 
		puts "---------------------"
		puts "Step 03: Grab references from Google doc and match with characters/episodes"
		puts "---------------------"
		puts 

	end

end