require "dry/cli"

module PokemonNameGenerator
  module CLI
    module Commands
      class Version < Dry::CLI::Command
        desc "Print version"

        def call(*)
          puts PokemonNameGenerator::VERSION
        end
      end
    end
  end
end
