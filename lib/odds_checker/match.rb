module OddsChecker
  class Match
    attr_reader :team_one, :team_two, :tournament

    def initialize(team_one:, team_two:, tournament:)
      @team_one = team_one
      @team_two = team_two
      @tournament = tournament
    end

    def tournament_url
      "http://www.oddschecker.com/#{tournament}/"
    end

    def url
      "#{tournament_url}#{team_one}-v-#{team_two}/"
    end
  end
end
