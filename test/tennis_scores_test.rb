require 'test/unit'
require './src/tennis_scores.rb'

class TestAdd < Test::Unit::TestCase
    def test_score_first_point
        scoring = TennisScores.new
        actual = scoring.scorePoint(1)
        expected = [[0, 0], [15, 0]]
        assert_equal expected, actual
    end

    def test_score_first_game
        scoring = TennisScores.new
        scoring.setScore([:adv, 40])
        actual = scoring.scorePoint(1)
        expected = [[1, 0], [0, 0]]
        assert_equal expected, actual
    end

    def test_take_adv
        scoring = TennisScores.new
        scoring.setScore([:adv, 15])
        actual = scoring.scorePoint(2)
        expected = [[0, 0], [40, 30]]
        assert_equal expected, actual
    end

    def test_win_first_set
        scoring = TennisScores.new
        scoring.setScore([:adv, 15], [[5, 0]])
        actual = scoring.scorePoint(1)
        expected = [[6, 0], [0, 0], [0, 0]]
        assert_equal expected, actual
    end
end
