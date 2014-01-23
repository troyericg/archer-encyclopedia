class Character < ActiveRecord::Base

	has_many :episodes
	has_many :references, :through => :episodes
	
end
