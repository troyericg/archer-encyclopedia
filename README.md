
The 'Archer' Encyclopedia
========================
The television show ['Archer'](http://www.fxnetworks.com/archer) is known for making references to obscure figures and subjects. This app helps make sense of them all.

(episode data from [The TVDB](http://thetvdb.com/))

Tasks
-----------
After your `bundle install` and your `rake db:migrate`: 
* `rake get:characters` add the list of characters to the database
* `rake get:episodes` to parse the TVDB xml and add all current episodes to the database 
* `rake get:parsed_references` to add the current set of references (**in progress**)