require 'spec_helper'

describe OddsChecker::Score do
  subject {
    described_class.new(
      team_one_goals: 2,
      team_two_goals: 1
    )
  }

  its(:team_one_goals) { is_expected.to eq(2) }
  its(:team_two_goals) { is_expected.to eq(1) }
  its(:difference) { is_expected.to eq(1) }
end
