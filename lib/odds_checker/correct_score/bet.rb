module OddsChecker
  module CorrectScore
    class Bet
      attr_reader :match, :score, :probability

      def initialize(match:, score:, probability:)
        @match = match
        @score = score
        @probability = probability
      end
    end
  end
end

