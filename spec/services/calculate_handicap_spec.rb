require 'yaml'
require 'json'
require 'models/round'
require 'services/calculate_handicap'

describe CalculateHandicap do
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

      it 'returns calculates the correct handicap' do
        expect(subject).to eq(12.6)
      end
    end
  end
end

