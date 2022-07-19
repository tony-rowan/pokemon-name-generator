module PokemonNameGenerator
  module Corpus
    module Names
      def self.as_letters(data: Data.new)
        data.load_pokemon_names.map(&:chars)
      end
    end
  end
end
