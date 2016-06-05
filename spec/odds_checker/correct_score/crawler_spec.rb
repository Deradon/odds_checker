require 'spec_helper'

describe OddsChecker::CorrectScore::Crawler do
  include WebmockStubs

  subject(:crawler) {
    described_class.new(
      match: match
    )
  }

  let(:match) {
    OddsChecker::Match.new(
      team_one: "france",
      team_two: "romania",
      tournament: "football/euro-2016"
    )
  }

  its(:match) { is_expected.to eq(match) }
  its(:url) { is_expected.to eq("http://www.oddschecker.com/football/euro-2016/france-v-romania/correct-score/") }


  its(:probability_sum) { is_expected.to be_within(0.0001).of(1.0) }

  describe "#bets" do
    subject(:bets) { crawler.bets }

    its(:length) { is_expected.to eq(57) }

    describe "an element" do
      subject(:element) { bets.first }

      let(:expected_score) {
        OddsChecker::Score.new(
          team_one_goals: 2,
          team_two_goals: 0
        )
      }

      it { is_expected.to be_a(OddsChecker::CorrectScore::Bet) }
      its(:score) { is_expected.to eq(expected_score) }
      its(:probability) { is_expected.to be_within(0.01).of(0.14) }
    end
  end
end
