require "odds_checker/version"

require "odds_checker/correct_score"
require "odds_checker/match"
require "odds_checker/score"

module OddsChecker
  def self.correct_score(*args)
    CorrectScore.for(*args)
  end
end
