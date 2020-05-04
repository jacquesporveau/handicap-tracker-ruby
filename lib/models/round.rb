class Round
  attr_reader :score, :course_rating, :slope_rating
  # @param score [Integer] the number of strokes the golfer took to complete the round.
  # @param course_rating [Float] the course rating for the round.
  # @param slope_rating [Float] the slope rating for the round.
  def initialize(score:, course_rating:, slope_rating:)
    @score = score
    @course_rating = course_rating
    @slope_rating = slope_rating
  end
end
