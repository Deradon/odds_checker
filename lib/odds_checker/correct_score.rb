require "odds_checker/correct_score/bet"
require "odds_checker/correct_score/crawler"
require "odds_checker/correct_score/result"

module OddsChecker
  module CorrectScore
    def self.for(input)
      if input.is_a?(Hash)
        Result.new(match: match_for(input))
      elsif input.is_a?(OddsChecker::Match)
        Result.new(match: input)
      else
        raise ArgumentError.new("#{input} is not a valid input")
      end
    end

    private

    def self.match_for(hash)
      Match.new(
        team_one: hash[:team_one],
        team_two: hash[:team_two],
        tournament: hash[:tournament]
      )
    end
  end
end
