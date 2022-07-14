require "lib_helper"

RSpec.describe PokemonNameGenerator::Algorithm::Factory do
  describe ".build_algorithm" do
    it "builds and returns an instance of the naive algorithm" do
      algorithm = PokemonNameGenerator::Algorithm::Factory.new(algorithm: "naive").build_algorithm

      expect(algorithm).to be_instance_of(PokemonNameGenerator::Algorithm::Naive)
    end

    it "builds and returns an instance of the markov algorithm" do
      algorithm = PokemonNameGenerator::Algorithm::Factory.new(algorithm: "markov", context: 3).build_algorithm

      expect(algorithm).to be_instance_of(PokemonNameGenerator::Algorithm::Markov)
    end

    it "throws an error when the length of the markov chain is not given" do
      expect { PokemonNameGenerator::Algorithm::Factory.new(algorithm: "markov").build_algorithm }
        .to raise_error(PokemonNameGenerator::Algorithm::InvalidContextError)
    end

    it "throws an error when the length of the markov chain is not an integer" do
      expect { PokemonNameGenerator::Algorithm::Factory.new(algorithm: "markov", context: "abc").build_algorithm }
        .to raise_error(PokemonNameGenerator::Algorithm::InvalidContextError)
    end
  end
end
