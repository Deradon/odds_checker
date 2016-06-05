module OddsChecker
  module CorrectScore
    class Result
      attr_reader :match

      def initialize(match:)
        @match = match
      end

      def bets
        crawler.bets
      end

      private

      def crawler
        @crawler ||= Crawler.new(match: match)
      end
    end
  end
end
