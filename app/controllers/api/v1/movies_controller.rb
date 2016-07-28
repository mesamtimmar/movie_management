module Api
  module V1
    class MoviesController < ApplicationController
      respond_to :json
      before_action :authenticate_request

      def index
        respond_with Movie.search_movies(params).page(params[:page])
      end

      def show
        @movie = Movie.find_by_id(params[:id])
        if @movie.present?
          respond_with @movie.details_hash
        else
          respond_with ["Error": "No Record Found"]
        end
      end

      def authenticate_request
       if request && request.headers && request.headers['Authorization']
         return if request.headers['Authorization'] == User::TOKEN
       end
       head :unauthorized
      end
    end
  end
end
