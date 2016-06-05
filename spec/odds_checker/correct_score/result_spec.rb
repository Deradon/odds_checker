require 'spec_helper'

describe OddsChecker::CorrectScore::Result do
  include WebmockStubs

  subject(:result) {
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

  describe "#bets" do
    subject(:bets) { result.bets }

    it { is_expected.to be_an(Array) }
    its(:length) { is_expected.to eq(57) }

    describe "an element" do
      subject { bets.first }

      it { is_expected.to be_a(OddsChecker::CorrectScore::Bet) }
    end
  end
end
