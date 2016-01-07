class MoviesController < ApplicationController
	before_action :set_movie,only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def search
		if params[:search].present?
			@movies = Movie.search(params[:search])
		else
			redirect_to "index"
		end
	end

	def index
		@movies = Movie.all.order("created_at  DESC")
	end

	def new
		@movie = current_user.movies.build
	end

	def create
		@movie = current_user.movies.build(movie_params)
		if(@movie.save)
			redirect_to @movie, notice: "Sucessfully created a movie"
		else
			render "new"
		end
	end

	def show
		@reviews = Review.where(movie_id: @movie.id).order("created_at DESC")

		if(@reviews.blank?)
			@avg_review = 0
		else
			@avg_review = @reviews.average(:rating).round(2)
		end
	end

	def edit
	end

	def update
		if @movie.update(movie_params)
			redirect_to @movie, notice: "Sucessfully updated the movie."
		else
			render "edit"
		end
	end

	def destroy
		@movie.destroy
		redirect_to root_path,notice: "Sucessfully deleted movie !"
	end

	private

	def set_movie
		@movie = Movie.find(params[:id])
	end

	def movie_params
		params.require(:movie).permit(:title, :description, :movie_length, :director, :rating, :image)
	end
end
