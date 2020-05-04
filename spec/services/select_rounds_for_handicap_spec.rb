require 'yaml'
require 'json'
require 'models/round'
require 'services/select_rounds_for_handicap'

describe SelectRoundsForHandicap do
  let(:instance) { described_class.new }

  describe '#call' do
    subject { instance.call(rounds: rounds) }

    context 'some rounds I played recently' do
			# TODO: Move this to a spec helper or factory etc.
      let(:rounds) do
				h = YAML.load(File.read('spec/fixtures/recent_rounds.yml'))
				r = JSON.parse(JSON[h], symbolize_names: true)

				r.fetch(:rounds).map do |x|
					Round.new(x)
				end
      end

      it 'returns an array of eight rounds' do
        expect(subject.length).to eq(8)
      end

      it 'picks the eight best rounds' do
        scores = subject.map(&:score)

        expect(scores).to contain_exactly(84, 84, 85, 85, 86, 86, 86, 87)
      end

      context 'when there are more than twenty rounds' do
        subject { instance.call(rounds: moar_rounds) }

        let(:moar_rounds) do
          [
            *rounds.first(20),
            Round.new(score: 72, course_rating: 70.9, slope_rating: 131)
          ]
        end

        it 'does not include scores from earlier than twenty rounds' do
          scores = subject.map(&:score)

          expect(scores).not_to include(72)
        end
      end
    end
  end
end

