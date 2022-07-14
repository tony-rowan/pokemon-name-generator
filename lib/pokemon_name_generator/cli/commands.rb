require "bundler/setup"
require "dry/cli"

module PokemonNameGenerator
  module CLI
    module Commands
      extend Dry::CLI::Registry

      class Version < Dry::CLI::Command
        desc "Print version"

        def call(*)
          puts PokemonNameGenerator::VERSION
        end
      end

      class Generate < Dry::CLI::Command
        desc "Generate one or more Pokémon Names"

        argument :algorithm, default: "markov", values: %w[naive markov], desc: "Algorithm to use"

        argument :context, type: :integer, default: 3, desc: "Number of links in the Markov Chain"

        argument :number, type: :integer, default: 1, desc: "Number of names to generate"

        def call(**options)
          corpus = Corpus.new

          algorithm = case options.fetch(:algorithm)
          when "naive" then Naive.new(corpus.pokemon_phonemes)
          when "markov" then Markov.new(corpus.pokemon_phonemes, context_length: options.fetch(:context))
          end

          options.fetch(:number).times { puts algorithm.generate_name }
        end
      end

      class Test < Dry::CLI::Command
        desc "Test an algorithm"

        argument :algorithm, values: %w[naive markov], desc: "Algorithm to test"

        argument :context, type: :integer, desc: "Number of links in the Markov Chain"

        argument :number, type: :integer, default: 10_000, desc: "Number of names to generate"

        def call(**options)
          corpus = Corpus.new
          actual_pokemon = corpus.pokemon
          all_data = corpus.pokemon_phonemes.shuffle

          longest_name = actual_pokemon.max_by(&:length)
          shortest_name = actual_pokemon.min_by(&:length)

          mid_point = (all_data.size + 1) / 2
          training_data = all_data[..mid_point]
          test_data = all_data[mid_point..]

          algorithm = case options.fetch(:algorithm)
          when "naive" then Naive.new(training_data)
          when "markov" then Markov.new(training_data, options.fetch(:context))
          else raise "Must provide a valid algorithm: naive or markov."
          end

          puts "============================="
          puts "🧪 Generator: #{algorithm.name}"
          puts "============================="

          generated_names = options.fetch(:number).times.map { algorithm.generate_name }

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

      register "version", Version, aliases: ["-v", "--version"]
      register "generate", Generate, aliases: ["g", "generate"]
      register "test", Test, aliases: ["t", "test"]
    end
  end
end
