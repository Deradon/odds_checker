require 'spec_helper'

describe OddsChecker::CorrectScore::Bet do
  subject {
    described_class.new(
      match: match,
      score: score,
      probability: probability
    )
  }

  let(:match) { instance_double(OddsChecker::Match) }
  let(:score) { instance_double(OddsChecker::Score) }
  let(:probability) { 0.23 }

  its(:match) { is_expected.to eq(match) }
  its(:score) { is_expected.to eq(score) }
  its(:probability) { is_expected.to eq(0.23) }
end
