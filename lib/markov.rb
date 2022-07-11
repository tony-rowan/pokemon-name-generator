class Markov
  def initialize(training_data, context_length:)
    @training_data = training_data
    @context_length = context_length
  end

  def name
    "Markov[#{@context_length}]"
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

  attr_reader :training_data, :context_length

  def statistics
    @statistics ||= load_statistics
  end

  def load_statistics
    markov_statistics = {}

    training_data.each do |this_pokemon_phonemes|
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

    markov_statistics[[]] = markov_statistics[[]].uniq

    markov_statistics
  end
end
