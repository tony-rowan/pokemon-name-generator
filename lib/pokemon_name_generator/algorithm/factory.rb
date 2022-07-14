module PokemonNameGenerator
  module Algorithm
    class Factory
      def initialize(training_data: Corpus.new.pokemon_phonemes, **options)
        @training_data = training_data
        @options = options
      end

      def build_algorithm
        case options.fetch(:algorithm)
        when "naive" then Naive.new(training_data)
        when "markov" then Markov.new(training_data, chain_length: context)
        end
      end

      private

        attr_reader :training_data, :options

        def context
          value = begin
            options.fetch(:context).to_i
          rescue
            raise InvalidContextError
          end

          raise InvalidContextError unless value > 0

          value
        end
    end
  end
end
