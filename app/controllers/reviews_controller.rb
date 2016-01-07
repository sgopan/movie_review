class ReviewsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_movie
	before_action :set_review, only: [:show, :edit, :destroy]

	def index
		@reviews = Review.all.order("created_at DESC")
	end

	def new
		@review = Review.new
	end

	def edit
	end

	def create 
		@review = Review.new(review_params)
		@review.user_id = current_user.id
		@review.movie_id = @movie.id
		if(@review.save)
			redirect_to @movie,notice: "Sucessfully created the review"
		else
			render "new"
		end

	end

	def update
		@review.update(review_params)
	end

	def destroy
		@review.destroy
		redirect_to @movie
	end


	private 

	def set_movie
		@movie = Movie.find(params[:movie_id])
	end

	def set_review
		@review = Review.find(params[:id])
	end

	def review_params
		params.require(:review).permit(:rating, :comment)
	end



end
