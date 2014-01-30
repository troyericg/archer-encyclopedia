class Episode < ActiveRecord::Base

	belongs_to :character
	belongs_to :reference

	# scope :specials,     {:conditions => [ "season == ?", "0" ]}
	# scope :season_one,   {:conditions => [ "season == ?", "1" ]}
	# scope :season_two,   {:conditions => [ "season == ?", "2" ]}
	# scope :season_three, {:conditions => [ "season == ?", "3" ]}
	# scope :season_four,  {:conditions => [ "season == ?", "4" ]}
	# scope :season_five,  {:conditions => [ "season == ?", "5" ]}
	
end
