class TrainersController < ApplicationController
  before_filter :authenticate_trainer!

  def index
    @trainers = Trainer.all
  end

  def show
    @trainers = Trainer.all
    @trainer = Trainer.find(params[:id])
    number = @trainer.id
    trainers_pokemon = Pokemon.where(trainer_id:number)
    @pokemon = trainers_pokemon.all
  end

end