require_relative "./lib/corpus"
require_relative "./lib/markov"
require_relative "./lib/naive"

require 'optparse'

options = {}
OptionParser.new do |parser|
  parser.banner = "Usage: generate_pokemon_name.rb [options]"

  parser.on("-a", "--algorithm NAME", "Algorithm to use; naive or markov") do |a|
    options[:algorithm] = a
  end

  parser.on("-c", "--context LENGTH", Integer, "Length of phonemes to user when building markov statistics") do |c|
    options[:context] = c
  end
end.parse!

corpus = Corpus.new
algorithm = case options[:algorithm]
  when "naive" then Naive.new(corpus)
  when "markov" then Markov.new(corpus, context_length: options[:context])
  else raise "Must provide alorithm name!"
end


puts algorithm.generate_name
