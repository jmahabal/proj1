class PokemonsController < ApplicationController

  def capture
  	@pokemon = Pokemon.find params[:id]
  	@pokemon.update(:trainer => current_trainer)
  	@pokemon.save
  	redirect_to '/'
  end
  
  def update
    @pokemon = Pokemon.find params[:id]
    @pokemon.update(pokemon_params)
    redirect_to pokemon_path(@pokemon)
  end

   def damagenoec
    @pokemon = Pokemon.find params[:damaged_pokemon]
  	new_health = @pokemon.health - 10
  	if new_health <= 0
  	  @pokemon.update(:faint => true)
  	  @pokemon.update(:health => 0)
  	else
  	  @pokemon.update(:health => new_health)
  	end
  	@pokemon.save
  	redirect_to trainer_path(@pokemon.trainer_id)
  end

  def damage
  	@damaging_pokemon = Pokemon.find params[:damaging_pokemon]
    @pokemon = Pokemon.find params[:damaged_pokemon]
  	new_health = @pokemon.health - @damaging_pokemon.level
  	if new_health <= 0
  	  @pokemon.update(:faint => true)
  	  @pokemon.update(:health => 0)
  	else
  	  @pokemon.update(:health => new_health)
  	end
  	new_experience = @damaging_pokemon.experience + @damaging_pokemon.level
  	if new_experience >= @damaging_pokemon.maxhealth
	  new_level = @damaging_pokemon.level + 1
	  new_experience = new_experience - @damaging_pokemon.maxhealth
      new_maxhealth = @damaging_pokemon.maxhealth + 10
  	  @damaging_pokemon.update(:level => new_level)
  	  @damaging_pokemon.update(:experience => new_experience)
      @damaging_pokemon.update(:maxhealth => new_maxhealth)
  	else
  	  @damaging_pokemon.update(:experience => new_experience)
  	end
  	@damaging_pokemon.save
  	@pokemon.save
  	redirect_to trainer_path(@pokemon.trainer_id)
  end

  def heal
  	@pokemon = Pokemon.find params[:id]
  	if @pokemon.faint == true
  	  @pokemon.update(:faint => false)
  	  @pokemon.update(:health => 10)
  	else
  	  new_health = @pokemon.health + 10
  	  if new_health < @pokemon.maxhealth
  	    @pokemon.update(:health => new_health)
  	  else
  	  	@pokemon.update(:health => @pokemon.maxhealth)
  	  end
  	end
  	@pokemon.save
  	redirect_to trainer_path(@pokemon.trainer_id)
  end

  def new
  	@pokemon = Pokemon.create
  end

  def create
  	@pokemon = Pokemon.new(pokemon_params)
  	if @pokemon.save
  	  @pokemon.update(:trainer => current_trainer)
  	  @pokemon.update(:health => 50)
  	  @pokemon.update(:level => 5)
  	  @pokemon.update(:faint => false)
  	  @pokemon.update(:maxhealth => 50)
  	  @pokemon.update(:experience => 0)
  	  redirect_to trainer_path(@pokemon.trainer_id)
  	else
  	  flash[:error] = @pokemon.errors.full_messages.to_sentence
  	  redirect_to new_pokemon_path
  	end
  end

  private

  def pokemon_params
  	params.required(:pokemon).permit(:name, :damaging_pokemon, :damaged_pokemon)
  end

end
