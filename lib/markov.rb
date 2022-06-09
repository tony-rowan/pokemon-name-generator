class Markov
  def initialize(corpus, context_length:)
    @corpus = corpus
    @context_length = context_length
  end

  def generate_name
    pokemon_name = ""
    context = []
    current_phoneme = statistics[context].sample

    loop do
      break if current_phoneme.nil?

      pokemon_name << current_phoneme
      context << current_phoneme
      context = context.drop(1) if context.size > context_length
      current_phoneme = statistics[context].sample
    end

    pokemon_name
  end

  private

  attr_reader :corpus, :context_length

  def statistics
    @statistics ||= load_statistics
  end

  def load_statistics
    markov_statistics = {}

    corpus.pokemon_phonemes.values.each do |this_pokemon_phonemes|
      context = []

      this_pokemon_phonemes.each do |this_pokemon_phoneme|
        if markov_statistics[context]
          markov_statistics[context] << this_pokemon_phoneme
        else
          markov_statistics[context] = [this_pokemon_phoneme]
        end

        context = [context, this_pokemon_phoneme].flatten
        context = context.drop(1) if context.size > context_length
      end

      if markov_statistics[context]
        markov_statistics[context] << nil
      else
        markov_statistics[context] = [nil]
      end
    end

    markov_statistics
  end
end
