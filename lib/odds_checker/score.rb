module OddsChecker
  class Score
    attr_reader :team_one_goals, :team_two_goals

    def initialize(team_one_goals:, team_two_goals:)
      @team_one_goals = team_one_goals
      @team_two_goals = team_two_goals
    end

    def difference
      team_one_goals - team_two_goals
    end

    def ==(other_score)
      other_score.team_one_goals == team_one_goals && other_score.team_two_goals == team_two_goals
    end
  end
end
