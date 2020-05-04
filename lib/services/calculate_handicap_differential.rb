class CalculateHandicapDifferential
  STANDARD_SLOPE_DIFFICULTY = 113.freeze
  DECIMAL_POINTS_TO_ROUND_TO = 1.freeze

  # @param round [Round] the round you want to calculate the handicap differential for.
  def call(round:)
    raw_differential = (round.score - round.course_rating) *
      STANDARD_SLOPE_DIFFICULTY / round.slope_rating

    raw_differential.round(DECIMAL_POINTS_TO_ROUND_TO)
  end
end
