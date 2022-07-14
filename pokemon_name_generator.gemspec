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
  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/tony-rowan/pokemon-name-generator"
  s.metadata["changelog_uri"] = "https://github.com/tony-rowan/pokemon-name-generator/blob/main/LICENSE.txt"

  s.files = Dir["{lib}/**/*.rb", "{data}/**/*.txt", "*.md", "bin/pokeng"]
  s.require_path = "lib"

  s.executables = ["pokeng"]

  s.add_runtime_dependency "dry-cli", "~> 0.7.0"

  s.add_development_dependency "aruba"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "standard"
end
