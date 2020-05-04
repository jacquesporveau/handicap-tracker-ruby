require 'services/calculate_handicap_differential'
require 'services/select_rounds_for_handicap'

class CalculateHandicap
  # @param calculate_handicap_differential [DuckTyped] a instance than calculates
  # a handicap differential for a round when the call method is invoked.
  # @param select_rounds_for_handicap [DuckTyped] a instance that selects
  # the rounds that should be used for a handicap.
  def initialize(
    calculate_handicap_differential: CalculateHandicapDifferential.new,
    select_rounds_for_handicap: SelectRoundsForHandicap.new
  )
    @calculate_handicap_differential = calculate_handicap_differential
    @select_rounds_for_handicap = select_rounds_for_handicap
  end

  # @param rounds [Array<Round>] all the Rounds a golfer has played.
  def call(rounds:)
    rounds_for_handicap = select_rounds_for_handicap.call(rounds: rounds)

    handicap_differentials = rounds_for_handicap.map do |round|
      calculate_handicap_differential.call(round: round)
    end

    summed_handicap_differentials = handicap_differentials.sum

    (summed_handicap_differentials / 8).round(1)
  end

  private

  attr_reader :calculate_handicap_differential, :select_rounds_for_handicap
end
