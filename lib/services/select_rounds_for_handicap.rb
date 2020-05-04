require 'services/calculate_handicap_differential'

class SelectRoundsForHandicap
  # The last 20 rounds are what the handicap formulas consider recent.
  QUANTIFY_RECENT = 20.freeze
  BEST_ROUNDS_TO_TAKE = 8.freeze

  # @param calculate_handicap_differential [DuckTyped] a instance than calculates
  # a handicap differential for a round when the call method is invoked.
  def initialize(
    calculate_handicap_differential: CalculateHandicapDifferential.new
  )
    @calculate_handicap_differential = calculate_handicap_differential
  end

  # @param rounds [Array<Round>] all the Rounds a golfer has played.
  def call(rounds:)
    recent_rounds = rounds.first(QUANTIFY_RECENT)

    best_to_worst = recent_rounds.sort_by do |round|
      calculate_handicap_differential.call(round: round)
    end

    best_to_worst.first(BEST_ROUNDS_TO_TAKE)
  end

  private

  attr_reader :calculate_handicap_differential
end
