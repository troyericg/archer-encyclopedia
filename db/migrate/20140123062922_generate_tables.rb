class GenerateTables < ActiveRecord::Migration
	def change
		create_table :characters do |t|
			t.string   "name"
			t.string   "actor"
			t.string   "summary"
			t.string   "image"

			t.timestamps
		end

		create_table :references do |t|
			t.string   "subject"
			t.string   "summary"
			t.string   "image"
			t.string   "link"
			t.string   "line"

			t.timestamps
		end

		create_table :episodes do |t|
			t.belongs_to :character
			t.belongs_to :reference
			t.integer  "number"
			t.integer  "season"
			t.string   "title"
			t.string   "summary"
			t.boolean  "flag"

			t.timestamps
		end
	end
end
