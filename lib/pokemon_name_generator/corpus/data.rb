module PokemonNameGenerator
  module Corpus
    class Data
      DATA_FILE_PATH = File.expand_path("../../../../data/pokemon.txt", __FILE__)

      attr_reader :file

      def initialize(file: DATA_FILE_PATH)
        @file = file
      end

      def load_pokemon_names
        File.readlines(file, chomp: true)
          .map { |line| line[5..] } # drop the number
          .map(&:downcase)
      end
    end
  end
end
