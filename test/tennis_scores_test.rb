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

    def test_score_first_game_no_adv
        scoring = TennisScores.new
        scoring.setScore([15, 40])
        actual = scoring.scorePoint(2)
        expected = [[0, 1], [0, 0]]
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
        scoring.setScore([40, 15], [[5, 0]])
        actual = scoring.scorePoint(1)
        expected = [[6, 0], [0, 0], [0, 0]]
        assert_equal expected, actual
    end

    def test_set_remains_if_less_than_two_games
        scoring = TennisScores.new
        scoring.setScore([40, 15], [[5, 5]])
        actual = scoring.scorePoint(1)
        expected = [[6, 5], [0, 0]]
        assert_equal expected, actual
    end

    def test_win_set_by_two_games
        scoring = TennisScores.new
        scoring.setScore([40, :adv], [[5, 6]])
        actual = scoring.scorePoint(2)
        expected = [[5, 7], [0, 0], [0, 0]]
        assert_equal expected, actual
    end
end
