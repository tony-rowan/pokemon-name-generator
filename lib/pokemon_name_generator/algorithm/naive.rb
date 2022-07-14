module PokemonNameGenerator
  module Algorithm
    class Naive
      def initialize(training_data)
        @training_data = training_data
      end

      def name
        "Naïve"
      end

      def generate_name
        statistics[:phoneme_count_distribution].sample.times.map { statistics[:phoneme_distribution].sample }.join
      end

      private

      attr_reader :training_data, :context_length

      def statistics
        @statistics ||= load_statistics
      end

      def load_statistics
        {
          phoneme_count_distribution: training_data.map(&:count),
          phoneme_distribution: training_data.flatten
        }
      end
    end
  end
end
