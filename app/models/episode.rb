class Episode < ActiveRecord::Base

	belongs_to :character
	belongs_to :reference
	
end
