require 'spec_helper'

describe OddsChecker::Score do
  subject(:score) {
    described_class.new(
      team_one_goals: team_one_goals,
      team_two_goals: team_two_goals
    )
  }

  let(:team_one_goals) { 2 }
  let(:team_two_goals) { 1 }

  its(:team_one_goals) { is_expected.to eq(2) }
  its(:team_two_goals) { is_expected.to eq(1) }
  its(:difference) { is_expected.to eq(1) }

  describe "#tendency" do
    subject { score.tendency }

    context "when team one has more goals than team two" do
      let(:team_one_goals) { 2 }
      let(:team_two_goals) { 1 }

      it { is_expected.to eq(:win) }
    end

    context "when team one has less goals than team two" do
      let(:team_one_goals) { 1 }
      let(:team_two_goals) { 2 }

      it { is_expected.to eq(:loss) }
    end

    context "when team one has same goals as team two" do
      let(:team_one_goals) { 2 }
      let(:team_two_goals) { 2 }

      it { is_expected.to eq(:draw) }
    end
  end
end
