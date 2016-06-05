require 'spec_helper'

describe OddsChecker::Match do
  subject {
    described_class.new(
      team_one: "france",
      team_two: "germany",
      tournament: "football/euro-2016"
    )
  }

  its(:team_one) { is_expected.to eq("france") }
  its(:team_two) { is_expected.to eq("germany") }
  its(:tournament) { is_expected.to eq("football/euro-2016") }

  its(:tournament_url) {
    is_expected.to eq("http://www.oddschecker.com/football/euro-2016/")
  }
end
