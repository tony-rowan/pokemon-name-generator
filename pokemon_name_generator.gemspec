require File.expand_path("../lib/pokemon_name_generator/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "pokemon_name_generator"
  s.version = PokemonNameGenerator::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "A tool to create new Pokémon names"
  s.homepage = "https://github.com/tony-rowan/pokemon-name-generator"
  s.authors = ["Tony Rowan"]
  s.email = "trowan812@gmail.com"
  s.license = "MIT"

  s.files = Dir["{lib}/**/*.rb", "*.md", "bin/pokeng"]
  s.require_path = "lib"

  s.executables = ["pokeng"]
end
