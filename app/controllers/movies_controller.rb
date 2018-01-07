class MoviesController < ApplicationController
 
  def index
  sort = params[:sort] || session[:sort]
  case sort
  when 'title'
    ordering,@title_header = {:title => :asc}, 'hilite'
  when 'release_date'
    ordering,@date_header = {:release_date => :asc}, 'hilite'
  end
  @all_ratings = Movie.all_ratings
  @selected_ratings = params[:ratings] || session[:ratings] || {}
   
  if @selected_ratings == {}
    @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
  end
   
  if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
    session[:sort] = sort
    session[:ratings] = @selected_ratings
    redirect_to :sort => sort, :ratings => @selected_ratings and return
  end
  @movies = Movie.where(rating: @selected_ratings.keys).order(ordering)
  end

 
 
  def show
  id = params[:id] # retrieve movie ID from URI route
  @movie = Movie.find(id) # look up movie by unique ID
  # will render app/views/movies/show.html.haml by default
  end
  
 # in movies_controller.rb
 def create
 params.require(:movie)
 permitted = params[:movie].permit(:title,:rating,:release_date)
 @movie = Movie.create!(permitted)
 flash[:notice] = “#{@movie.title} was successfully created.”
 redirect_to movies_path
 end


 # in movies_controller.rb
 def edit
 @movie = Movie.find params[:id]
 end

 def update
 @movie = Movie.find params[:id]
 params.require(:movie)
 permitted = params[:movie].permit(:title,:rating,:release_date)
 @movie.update_attributes!(permitted)
 flash[:notice] = #{@movie.title} was successfully updated.
 redirect_to movie_path(@movie)
 end

 
 def destroy
 @movie = Movie.find(params[:id])
 @movie.destroy
 flash[:notice] = "Movie '#{@movie.title}' deleted."
 redirect_to movies_path
 end
 
 




end
