module Api
  module V1
    class MoviesController < ApplicationController
      respond_to :json

      def index
        if (params[:title] || params[:genre] || params[:actors] || params[:release_date])
          respond_with Movie.search_movie(params)
        else
          respond_with Movie.all
       end
      end

      def show
        @movie = Movie.find_by_id(params[:id])
        if @movie.present?
          respond_with @movie.details_hash
        else
          respond_with []
        end
      end
    end
  end
end
