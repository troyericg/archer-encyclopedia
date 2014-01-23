namespace :db do
	desc "Testing Season Data"
	task :run_data_test => :environment do

		# necessary variables
		character_list = ["Sterling Archer", "Lana Kane", "Malory Archer", "Cyril Figgis", "Cheryl/Carol Tunt", "Pam Poovey", "Dr. Krieger", "Ray Gillette", "Woodhouse"]
		episodes_by_season = []
		all_characters = []

		# erase current items in database
		[Character, Episode, Reference].each do |type|
			type.delete_all
		end

		character_list.each do |charact|
			cHsh = { :name => charact, :bio => "#{charact} is a person and has led an interesting life." }
			all_characters << cHsh
		end

		
		# generates an array of hashes. one for each episode
		4.times do |tiem|
			tiemUp = tiem + 1

			13.times do |tiempo|
				tiempoUp = tiempo + 1
				eHsh = { :name => tiempoUp, :title => "Episode #{tiempoUp} of Archer", :season => tiemUp }
				episodes_by_season << eHsh
			end
		end

		ref_1 = Reference.create(:subject => "Michael Findlay", :bio => "Michael Findlay, along with his wife Roberta Findlay, directed and produced numerous sexploitation movies. They have been described as 'the most notorious filmmakers in the annals of sexploitation'.")
		woodhouse = Character.create(:name => "Woodhouse", :bio => "Sterling Archer's Heroin-addicted manservant.")
		ep_1 = Episode.create(:ep_number => "1", :season => "1", :title => "A title", :summary => "A very special episode of Archer")

		#cObj.references << rObj
		# ep_1 << ref_1
		woodhouse.references << ref_1
		ref_1.episodes << ep_1
		woodhouse.episodes << ep_1
		puts "new records created"

		# puts "-------------"
		# puts Character.first.attributes
		# puts Character.first.references.first.attributes
		# puts "-------------"

	end

end

