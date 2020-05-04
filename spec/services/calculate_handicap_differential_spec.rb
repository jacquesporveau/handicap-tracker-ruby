require 'models/round'
require 'services/calculate_handicap_differential'

describe CalculateHandicapDifferential do
  let(:instance) { described_class.new }

  describe '#call' do
    subject { instance.call(round: round) }

    context 'a round I played recently' do
      let(:round) do
        Round.new(score: 89, course_rating: 70.9, slope_rating: 131)
      end

      it { is_expected.to eq(15.6) }
    end

    context 'a round I played in Scottsdale' do
      let(:round) do
        Round.new(score: 89, course_rating: 67.6, slope_rating: 124)
      end

      it { is_expected.to eq(19.5) }
    end

    context 'a round I played in Salmon Arm' do
      let(:round) do
        Round.new(score: 93, course_rating: 71.2, slope_rating: 130)
      end

      it { is_expected.to eq(18.9) }
    end
  end
end
