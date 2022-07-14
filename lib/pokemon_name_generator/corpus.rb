module PokemonNameGenerator
  class Corpus
    def pokemon_letters
      @pokemon_letters ||= load_pokemon_letters.values
    end

    def pokemon_phonemes
      @pokemon_phonemes ||= load_pokemon_phonemes.values
    end

    def phonemes
      @phonemes ||= Phoneme.load_data
    end

    def pokemon
      @pokemon ||= Pokemon.load_data
    end

    private

    # This generates a hash so we can debug it easily
    def load_pokemon_letters
      pokemon.map { |name| [name, name.chars] }.to_h
    end

    # This generates a hash so we can debug it easily
    def load_pokemon_phonemes
      pokemon.map do |this_pokemon_name|
        remaining_pokemon_name = this_pokemon_name
        this_pokemon_phonemes = []

        loop do
          break if remaining_pokemon_name.empty?

          phoneme = phonemes.find { |phoneme| remaining_pokemon_name.start_with?(phoneme) }

          this_pokemon_phonemes << phoneme
          remaining_pokemon_name = remaining_pokemon_name.sub(phoneme, "")
        end

        [this_pokemon_name, this_pokemon_phonemes]
      end.to_h
    end
  end
end
