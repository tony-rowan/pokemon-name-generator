require_relative "./lib/corpus"
require_relative "./lib/markov"
require_relative "./lib/naive"

corpus = Corpus.new

shortest_name = corpus.pokemon.min_by(&:length)
longest_name = corpus.pokemon.max_by(&:length)

generators = {
  naive: Naive.new(corpus),
  markov_0: Markov.new(corpus, context_length: 0),
  markov_1: Markov.new(corpus, context_length: 1),
  markov_2: Markov.new(corpus, context_length: 2),
  markov_3: Markov.new(corpus, context_length: 3),
  markov_4: Markov.new(corpus, context_length: 4),
  markov_5: Markov.new(corpus, context_length: 5),
}

generators.each do |generator_name, generator|
  puts "============================="
  puts "🧪 Generator: #{generator_name}"
  puts "============================="

  real_pokemon_generated = 0
  short_names = 0
  long_names = 0

  100.times do
    name = generator.generate_name

    real_pokemon_generated += 1 if corpus.pokemon.include?(name)
    short_names += 1 if name.length < shortest_name.length - 1
    long_names += 1 if name.length > longest_name.length + 1
  end

  puts "Real Pokemon Names: #{real_pokemon_generated}"
  puts "Overly Short Names: #{short_names}"
  puts "Overly Long Names: #{long_names}"

  puts ""
end
