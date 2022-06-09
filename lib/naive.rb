class Naive
  def initialize(corpus)
    @corpus = corpus
  end

  def generate_name
    statistics[:phoneme_count_distribution].sample.times.map { statistics[:phoneme_distribution].sample }.join
  end

  private

  attr_reader :corpus, :context_length

  def statistics
    @statistics ||= load_statistics
  end

  def load_statistics
    {
      phoneme_count_distribution: corpus.pokemon_phonemes.values.map(&:count),
      phoneme_distribution: corpus.pokemon_phonemes.values.flatten
    }
  end
end
