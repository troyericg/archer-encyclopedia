class Reference < ActiveRecord::Base

	has_many :episodes
	has_many :characters, :through => :episodes

end
