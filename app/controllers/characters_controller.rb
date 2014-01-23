class CharactersController < ApplicationController

	def index 
		@characters = Character.all
		@episodes = Episode.all
	end

end
