class EpisodesController < ApplicationController
	
	def index
		@episodes = Episode.all
		@seasons = @episodes.group_by{|e| e['season']}
	end

	def show
		@seasons = Episode.all.group_by{|e| e['season']}
		respond_to do |format|
			format.any { render :json => @seasons }
		end
	end

end
