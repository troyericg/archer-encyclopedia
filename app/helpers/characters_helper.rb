module CharactersHelper

	def category_list(model)
		cat_list = []
		model.references.each do |ref|
			cat_list << ref.category
		end

		cat_list.uniq
	end
end
