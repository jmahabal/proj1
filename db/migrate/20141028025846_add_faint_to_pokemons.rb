class AddFaintToPokemons < ActiveRecord::Migration
  def change
    add_column :pokemons, :faint, :boolean
  end
end
