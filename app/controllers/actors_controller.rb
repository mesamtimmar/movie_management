class ActorsController < ApplicationController

  def show
    @actor = Actor.find(params[:id])
    @movies_worked_in = @actor.movies_worked_in(params)
  end
end
