
# add to the search_for_movies_by_director_steps.rb

Then(/^the director of "([^"]*)" should be "([^"]*)"$/) do |arg1, arg2|
  Movie.find_by_title(arg1).director == arg2
end
