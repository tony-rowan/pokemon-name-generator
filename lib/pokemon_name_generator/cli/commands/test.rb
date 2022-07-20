require "dry/cli"

module PokemonNameGenerator
  module CLI
    module Commands
      class Test < Dry::CLI::Command
        desc "Test an algorithm"

        option :algorithm, required: true, values: %w[naive markov], desc: "Algorithm to test"

        option :context, required: true, type: :integer, desc: "Number of links in the Markov Chain"

        option :number, type: :integer, default: 10_000, desc: "Number of names to generate"

        def call(**options)
          actual_pokemon = Corpus::Data.new.load_pokemon_names
          all_data = Corpus::Names.as_letters.shuffle

          longest_name = actual_pokemon.max_by(&:length)
          shortest_name = actual_pokemon.min_by(&:length)

          mid_point = (all_data.size + 1) / 2
          training_data = all_data[..mid_point]
          test_data = all_data[mid_point..]

          algorithm = Algorithm::Factory.new(training_data: training_data, **options).build_algorithm

          puts "============================="
          puts "🧪 Generator: #{algorithm.name}"
          puts "============================="

          generated_names = options.fetch(:number).to_i.times.map { algorithm.generate_name }

          puts "Training Data: #{training_data.size}"
          puts "Test Data: #{test_data.size}"
          puts "Generated Names: #{generated_names.size}"
          puts "Unique Generated Names: #{generated_names.uniq.size}"
          puts "Training Data Names Generated: #{training_data.map { |datum| datum.join("") }.intersection(generated_names.uniq).size}"
          puts "Test Data Names Generated: #{test_data.map { |datum| datum.join("") }.intersection(generated_names.uniq).size}"
          puts "Test Data Names Generated: #{test_data.map { |datum| datum.join("") }.intersection(generated_names.uniq)}"
          puts "Overly Short Names: #{generated_names.count { |name| name.size < shortest_name.size }}"
          puts "Overly Long Names: #{generated_names.count { |name| name.size > longest_name.size }}"
          puts ""
        end
      end
    end
  end
end
