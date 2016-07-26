class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :set_posters, only: [:show]
  before_action :set_all_actors, only: [:new, :create, :edit, :update]
  before_action :set_selected_actors, only: [:edit, :update]
  before_action :authenticate_movie, only: [:show]

  # GET /movies
  # GET /movies.json
  def index
    if params[:search]
      @movies = Movie.search_movies(params).latest.approved
    else
      @movies = Movie.with_category(params[:filter]).latest_movies.approved
    end
    @movies = @movies.page(params[:page])
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @reviews = @movie.reviews.select(&:persisted?)
    @review = @movie.reviews.build
    @ratings = @movie.ratings
    @rating = @movie.get_ratings(current_user) if user_signed_in?
    respond_to do |format|
      format.html
      format.json { render json: @movie }
    end
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def set_posters
      @posters = @movie.posters
    end

    def set_all_actors
      @all_actors = Actor.all
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :genre, :duration, :release_date, :trailer, :description, :approved, :featured, actor_ids: [], posters_attributes: [:id, :image, :_destroy])
    end

    def set_selected_actors
      @selected_actors = @movie.actor_ids
    end

    def authenticate_movie
      redirect_to root_path, alert: 'Movie not approved' unless @movie.approved?
    end
end
