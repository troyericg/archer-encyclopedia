class EpisodesController < ApplicationController
	@episodes = Episode.all

	@season_specials = Episode.specials
	@season_one = Episode.season_one
	@season_two = Episode.season_two
	@season_three = Episode.season_three
	@season_four = Episode.season_four
	@season_five = Episode.season_five
end
