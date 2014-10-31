class AddMaxHealthToPokemons < ActiveRecord::Migration
  def change
    add_column :pokemons, :maxhealth, :integer
  end
end
