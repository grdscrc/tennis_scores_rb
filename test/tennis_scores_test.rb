require 'test/unit'
require './src/tennis_scores.rb'

class TestAdd < Test::Unit::TestCase
    def test_score_first_point
        scoring = TennisScores.new
        actual = scoring.scorePoint(1)
        expected = [[0, 0], [15, 0]]
        assert_equal expected, actual
    end
end
