require "dry/cli"

module PokemonNameGenerator
  module CLI
    module Commands
      class Generate < Dry::CLI::Command
        desc "Generate one or more Pokémon Names"

        option :algorithm, default: "markov", values: %w[naive markov], desc: "Algorithm to use"

        option :context, type: :integer, default: 3, desc: "Number of links in the Markov Chain"

        option :number, type: :integer, default: 1, desc: "Number of names to generate"

        def call(**options)
          algorithm = Algorithm::Factory.new(**options).build_algorithm

          puts "============================="
          puts "🧪 Generator: #{algorithm.name}"
          puts "============================="
          puts ""

          if options.fetch(:number).to_i > 1
            puts "Generating #{options.fetch(:number)} names..."
            puts ""
          end

          options.fetch(:number).to_i.times { puts algorithm.generate_name }
        end
      end
    end
  end
end
