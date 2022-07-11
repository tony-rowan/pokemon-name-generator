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

  parser.on("-c", "--context LENGTH", Integer, "Markov Only. Length of the markov chain to use.") do |c|
    options[:context] = c
  end
end.parse!

corpus = Corpus.new
actual_pokemon = corpus.pokemon
all_data = corpus.pokemon_phonemes.shuffle

longest_name = actual_pokemon.max_by(&:length)
shortest_name = actual_pokemon.min_by(&:length)

mid_point = (all_data.size + 1) / 2
training_data = all_data[..mid_point]
test_data = all_data[mid_point..]

algorithm = case options[:algorithm]
  when "naive" then Naive.new(training_data)
  when "markov" then Markov.new(training_data, context_length: options[:context])
  else raise "Must provide a valid algorithm: naive or markov."
end

puts "============================="
puts "🧪 Generator: #{algorithm.name}"
puts "============================="

generated_names = 5000.times.map { algorithm.generate_name }

puts "Training Data: #{training_data.size}"
puts "Test Data: #{test_data.size}"
puts "Generated Names: #{generated_names.size}"
puts "Unique Generated Names: #{generated_names.uniq.size}"
puts "Training Data Names Generated: #{training_data.map { |datum| datum.join("") }.intersection(generated_names.uniq).size}"
puts "Test Data Names Generated: #{test_data.map { |datum| datum.join("") }.intersection(generated_names.uniq).size}"
puts "Test Data Names Generated: #{test_data.map { |datum| datum.join("") }.intersection(generated_names.uniq)}"
puts "Overly Short Names: #{generated_names.select { |name| name.size < shortest_name.size }.count}"
puts "Overly Long Names: #{generated_names.select { |name| name.size > longest_name.size }.count}"
puts ""
