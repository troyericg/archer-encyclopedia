require 'rest-client'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

namespace :get do

	desc "Get character data from Wikipedia"
	task :characters => :environment do

		# constants
		URL_WIKI = "http://en.wikipedia.org/wiki"
		URL_WIKI_ARCHER = "#{URL_WIKI}/Archer_(TV_series)"

		character_skeleton = {
			:name => nil,
			:actor => nil,
			:summary => nil,
			:image => nil,
			:num_appearances => nil
		}

		character_data = [
			{
				:name => "Sterling Malory Archer",
				:actor => "H. Jon Benjamin",
				:summary => "Codename: Duchess. 184 lb, 6\'2\", 36 years old, and is considered the world's most dangerous secret agent and is similar to James Bond. He is extremely egotistical and self-involved. Though he shows proficiency in stereotypical spy skills (weapons, driving, martial arts) his only real interest in the job is the opportunity to enjoy a jet-setting lifestyle full of sex, alcohol, thrills, lacrosse, fast cars, spy gadgets and turtleneck sweaters.",
				:image => nil,
				:num_appearances => nil
			},
			{
				:name => "Lana Kane",
				:actor => "Aisha Tyler",
				:summary => "The top female agent at ISIS and Archer's ex-girlfriend. A tall, beautiful woman, she is a competent and deadly agent but is constantly frustrated that she is treated as the number two ISIS field agent because Archer's mother runs the agency. The fact that she is tall and has abnormally large hands are often a source of fodder for jokes at her expense. She is revealed to be pregnant at the end of the fourth season, though the identity of the father is currently unknown, aside from it not being Cyril Figgis. Her name is reminiscent of Lanacane, a pharmaceutical company that produces anti-itching cream.",
				:image => nil,
				:num_appearances => nil
			},
			{
				:name => "Malory Archer",
				:actor => "Jessica Walter",
				:summary => "Sterling Archer's mother and the head of ISIS, is a self-centered alcoholic who regularly hatches half-baked, invariably disastrous schemes to use the agency's resources to her own personal advantage. She has staged a false assassination attempt on a U.N. official to secure a lucrative government contract, called in fake threats to restaurants and air ships in order to get reservations and cabin berths, sent ISIS agents to blow up an oil pipeline in Turkmenistan, murdered the Prime Minister of Italy and tricked the ISIS staff into disposing of the body, assisted a coyote syndicate so she could use the reward money to redecorate her office, and attempted to salvage a hydrogen bomb from the ocean so she could ransom it back to the U.S. government.",
				:image => nil,
				:num_appearances => nil
			},
			{
				:name => "Cyril Figgis",
				:actor => "Chris Parnell",
				:summary => "Comptroller of ISIS. Cyril is portrayed as quite competent at his job, but is plagued by a number of personal issues. He is eventually promoted to secret agent, but is incredibly incompetent at that. He was Lana Kane's love interest at the beginning of Season 1, but due to residual trust issues from her relationship with Archer (and her finding out Cyril was cheating on her repeatedly), she refused to call Cyril her boyfriend or say she loved him.",
				:image => nil,
				:num_appearances => nil
			},
			{
				:name => "Cheryl Tunt",
				:actor => "Judy Greer",
				:summary => "Malory's secretary. In the pilot episode, she was portrayed as a lovesick, ditzy secretary frequently taken advantage of by Archer, but that side of her character was gradually phased out as her behavior became more and more unhinged: she has pyromaniac and sadomasochistic tendencies and is often sniffing or swallowing rubber cement. She is also revealed to be an heiress with a fortune of half a billion dollars (it was one billion, but she had to split it with her \"stupid brother Cecil\").",
				:image => nil,
				:num_appearances => nil
			},
			{
				:name => "Pamela \"Pam\" Poovey",
				:actor => "Amber Nash",
				:summary => "ISIS's human resources director. A gossipy pot smoker who is the brunt of many jokes regarding her weight, she serves as a foil for most of the members of the cast, often calling them out on their zany schemes. Though not a field agent (until season four, episode ten), she is a trained drift car racer and bare knuckle fighter, with over a dozen kills under her belt (represented on her back, along with the third verse of Lord Byron's poem \"The Destruction of Sennacherib\" in tattoo form). Among her other interests are graffiti, directing amateur tentacle porn, and cock-fighting with Siamese fighting fish.",
				:image => nil,
				:num_appearances => nil
			},
			{
				:name => "Mr. Doctor Algernop Krieger",
				:actor => "Lucky Yates",
				:summary => "The head of the ISIS applied research department. He spends most of his time working on projects to facilitate his kinky sexual fantasies. He has had several holographic anime-style girlfriends, and has developed the technology to turn human beings into cyborgs. It is discovered he shares blood ties to Adolf Hitler, being one of the \"Boys from Brazil\". He has an affinity for Rush and in one episode is shown to own a drum kit identical to that of Rush drummer Neil Peart. He is not an actual doctor, however: Doctor is his first name.",
				:image => nil,
				:num_appearances => nil
			},
			{
				:name => "Ray Gillette",
				:actor => "Adam Reed",
				:summary => "Openly gay intelligence analyst and one of the few competent members of ISIS. Along with Lana, he serves as the voice of reason on the show. Raised in an impoverished part of West Virginia, he was once an ordained minister, as well as an Olympic bronze medalist in giant slalom. He spent most of season three pretending to be paralyzed after being injured on a rescue mission, but was actually paralyzed following a space shuttle crash at the end of the season. In season four, he receives bionic legs, allowing him to walk again, however in the season four finale, the CPU controlling his bionic legs is damaged, rendering him once again paralyzed in a wheelchair. Gillette appeared only three times in the first season, becoming a regular character from the second onward.",
				:image => nil,
				:num_appearances => nil
			},
			{
				:name => "Woodhouse",
				:actor => "George Coe, Roy McCrery in flashbacks",
				:summary => "Sterling's long-suffering, heroin-addict, English valet, who patiently accepts the unending stream of abuse hurled at him by Archer, in part due to Archer's resemblance to a pilot friend of his from World War I whom Woodhouse had an unrequited crush on. He also bears an uncanny resemblance to the Pope, as revealed in the fourth season.",
				:image => nil,
				:num_appearances => nil
			}
		]

		
		# test 
		puts 
		puts "---------------------"
		puts "Step 02: Grab this character info - #{URL_WIKI_ARCHER}"
		puts "---------------------"
		puts 

	end

end