class Movie < ActiveRecord::Base
    def self.all_ratings ; %w[G PG PG-13 R NC-17] ; end #  shortcut: array of strings
    def self.similar_movies(movie)
    Movie.where director: movie.director
    end

end