class SelectRoundsForHandicap
  # The last 20 rounds are what the handicap formulas consider recent.
  QUANTIFY_RECENT = 20.freeze
  BEST_ROUNDS_TO_TAKE = 8.freeze

  # @param rounds [Array<Round>] all the Rounds a golfer has played.
  def call(rounds:)
    recent_rounds = rounds.first(QUANTIFY_RECENT)

    best_to_worst = recent_rounds.sort_by do |round|
      round.handicap_differential
    end

    best_to_worst.first(BEST_ROUNDS_TO_TAKE)
  end
end
