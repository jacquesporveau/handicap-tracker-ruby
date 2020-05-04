require 'models/round'
require 'services/select_rounds_for_handicap'

describe SelectRoundsForHandicap do
  let(:instance) { described_class.new }

  describe '#call' do
    subject { instance.call(rounds: rounds) }

    context 'some rounds I played recently' do
      let(:rounds) do
        [
          Round.new(score: 71, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 72, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 92, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 90, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 85, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 89, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 93, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 82, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 87, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 84, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 81, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 82, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 69, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 84, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 85, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 86, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 87, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 88, course_rating: 70.9, slope_rating: 131),
          Round.new(score: 89, course_rating: 67.6, slope_rating: 124),
          Round.new(score: 93, course_rating: 71.2, slope_rating: 130),
        ]
      end

      it 'returns an array of eight rounds' do
        expect(subject.length).to eq(8)
      end

      it 'picks the eight best rounds' do
        scores = subject.map(&:score)

        expect(scores).to contain_exactly(69, 71, 72, 81, 82, 82, 84, 84)
      end

      context 'when there are more than twenty rounds' do
        subject { instance.call(rounds: moar_rounds) }

        let(:moar_rounds) do
          [
            *rounds,
            Round.new(score: 68, course_rating: 70.9, slope_rating: 131)
          ]
        end

        it 'does not include scores from earlier than twenty rounds' do
          scores = subject.map(&:score)

          expect(scores).not_to include(68)
        end
      end
    end
  end
end

