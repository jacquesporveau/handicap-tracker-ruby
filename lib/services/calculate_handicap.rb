require 'services/select_rounds_for_handicap'

class CalculateHandicap
  # @param select_rounds_for_handicap [DuckTyped] a instance that selects
  # the rounds that should be used for a handicap.
  def initialize(select_rounds_for_handicap: SelectRoundsForHandicap.new)
    @select_rounds_for_handicap = select_rounds_for_handicap
  end

  # @param rounds [Array<Round>] all the Rounds a golfer has played.
  def call(rounds:)
    rounds_for_handicap = select_rounds_for_handicap.call(rounds: rounds)

    handicap_differentials = rounds_for_handicap.map do |round|
      round.handicap_differential
    end

    summed_handicap_differentials = handicap_differentials.sum

    (summed_handicap_differentials / 8).round(1)
  end

  private

  attr_reader :select_rounds_for_handicap
end
