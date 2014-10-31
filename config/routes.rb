Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :trainers
  resources :trainers, :pokemons
  patch '/capture' => 'pokemons#capture'
  patch '/damage' => 'pokemons#damage'
  patch '/update' => 'pokemons#update'
  patch '/heal' => 'pokemons#heal'
  post '/create' => 'pokemons#create'
end
