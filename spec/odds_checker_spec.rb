require 'spec_helper'

describe OddsChecker do
  it 'has a version number' do
    expect(OddsChecker::VERSION).not_to be nil
  end

  describe ".correct_score" do
    subject {
      described_class.correct_score(
        team_one: "france",
        team_two: "romania",
        tournament: "football/euro-1016"
      )
    }

    it { is_expected.to be_a(OddsChecker::CorrectScore::Result) }
  end
end
