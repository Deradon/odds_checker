require 'spec_helper'

describe OddsChecker::CorrectScore do
  let(:match) {
    OddsChecker::Match.new(
      team_one: "france",
      team_two: "germany",
      tournament: "football/euro-2016"
    )
  }

  describe ".for(match)" do
    subject { described_class.for(input) }

    context "when match given" do
      let(:input) { match }

      it { is_expected.to be_a(OddsChecker::CorrectScore::Result) }
    end

    context "when hash given" do
      let(:input) {
        {
          team_one: "france",
          team_two: "germany",
          tournament: "football/euro-2016"
        }
      }

      it { is_expected.to be_a(OddsChecker::CorrectScore::Result) }
    end
  end
end
