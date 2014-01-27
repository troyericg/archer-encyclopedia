class CharactersController < ApplicationController

	def index 
		@characters = Character.all
		@episodes = Episode.all
		@references = Reference.all
	end

end
