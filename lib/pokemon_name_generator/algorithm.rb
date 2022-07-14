module PokemonNameGenerator
  module Algorithm
    class InvalidContextError < StandardError; end

    require "pokemon_name_generator/algorithm/factory"
    require "pokemon_name_generator/algorithm/markov"
    require "pokemon_name_generator/algorithm/naive"
  end
end
