require "dry/cli"

module PokemonNameGenerator
  module CLI
    module Commands
      class Test < Dry::CLI::Command
        desc "Test an algorithm"

        option :algorithm, required: true, values: %w[naive markov], desc: "Algorithm to test"

        option :context, required: true, type: :integer, desc: "Number of links in the Markov Chain"

        option :sample, type: :integer, default: 10_000, desc: "Number of names to generate"

        option :show_names, type: :boolean, default: false, desc: "Show the new and actual generated names in the sample"

        def call(**options)
          actual_pokemon = Corpus::Data.new.load_pokemon_names
          all_data = Corpus::Names.as_letters.shuffle

          mid_point = (all_data.size + 1) / 2
          training_data = all_data[..mid_point]
          test_data = all_data[mid_point..]

          algorithm = Algorithm::Factory.new(training_data: training_data, **options).build_algorithm

          puts "============================="
          puts "🧪 Generator: #{algorithm.name}"
          puts "============================="

          puts "Generating #{options.fetch(:sample)} names..."

          generated_names = options.fetch(:sample).to_i.times.map { algorithm.generate_name }

          unique_pokemon_generated = generated_names.uniq
          training_pokemon_generated = unique_pokemon_generated.intersection(training_data.map(&:join))
          test_pokemon_generated = unique_pokemon_generated.intersection(test_data.map(&:join))
          new_pokemon_generated = unique_pokemon_generated - actual_pokemon

          puts "Done."
          puts ""
          puts "Unique Names: #{unique_pokemon_generated.size}"
          puts "Training Pokémon: #{training_pokemon_generated.size}"
          puts "#{training_pokemon_generated}" if options.fetch(:show_names, false)
          puts "Test Pokémon: #{test_pokemon_generated.size}"
          puts "#{test_pokemon_generated}" if options.fetch(:show_names, false)
          puts "New Pokémon: #{new_pokemon_generated.size}"
          puts "#{new_pokemon_generated}" if options.fetch(:show_names, false)
          puts ""
        end
      end
    end
  end
end
