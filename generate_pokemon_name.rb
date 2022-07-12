require_relative "./lib/corpus"
require_relative "./lib/markov"
require_relative "./lib/naive"

require 'optparse'

options = {}
OptionParser.new do |parser|
  parser.banner = "Usage: generate_pokemon_name.rb [options]"

  parser.on("-a", "--algorithm NAME", "Algorithm to use: naive or markov.") do |a|
    options[:algorithm] = a
  end

  parser.on("-c", "--context LENGTH", Integer, "Markov Only. Length of the markov chain to use. Default 3.") do |c|
    options[:context] = c
  end

  parser.on("-n", "--number COUNT", Integer, "Number of names to generate. Default 1") do |n|
    options[:number] = n
  end
end.parse!

corpus = Corpus.new

pp corpus.send(:load_pokemon_phonemes)["charmander"]

algorithm = case options.fetch(:algorithm, "markov")
  when "naive" then Naive.new(corpus.pokemon_phonemes)
  when "markov" then Markov.new(corpus.pokemon_phonemes, context_length: options.fetch(:context, 3))
  else raise "Must provide a valid algorithm: naive or markov."
end


options.fetch(:number, 1).times { puts algorithm.generate_name }
