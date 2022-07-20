require "bundler/setup"
require "dry/cli"

module PokemonNameGenerator
  module CLI
    module Commands
      require "pokemon_name_generator/cli/commands/version"
      require "pokemon_name_generator/cli/commands/generate"
      require "pokemon_name_generator/cli/commands/test"

      extend Dry::CLI::Registry

      register "version", Version, aliases: ["-v", "--version"]
      register "generate", Generate, aliases: ["g", "generate"]
      register "test", Test, aliases: ["t", "test"]
    end
  end
end
