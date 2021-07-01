require 'test/unit'
require './src/tennis_scores.rb'

class TennisScoresTest < Test::Unit::TestCase
    def setup
        @scoring = TennisScores.new    
    end

    def teardown
        assert_equal @expected, @actual
    end

    # games
    def test_score_first_point
        @actual = @scoring.scorePoint(1)
        @expected = [[[0, 0]], [15, 0]]
    end

    def test_score_first_game
        @scoring.setScore([:adv, 40])

        @actual = @scoring.scorePoint(1)
        @expected = [[[1, 0]], [0, 0]]
    end

    def test_score_first_game_no_adv
        @scoring.setScore([15, 40])

        @actual = @scoring.scorePoint(2)
        @expected = [[[0, 1]], [0, 0]]
    end

    def test_take_adv
        @scoring.setScore([:adv, 15])

        @actual = @scoring.scorePoint(2)
        @expected = [[[0, 0]], [40, 30]]
    end

    # sets
    def test_win_first_set
        @scoring.setScore([40, 15], [[5, 0]])

        @actual = @scoring.scorePoint(1)
        @expected = [[[6, 0], [0, 0]], [0, 0]]
    end

    def test_set_remains_if_less_than_two_games
        @scoring.setScore([40, 15], [[5, 5]])

        @actual = @scoring.scorePoint(1)
        @expected = [[[6, 5]], [0, 0]]
    end

    def test_win_set_by_two_games
        @scoring.setScore([40, :adv], [[5, 6]])

        @actual = @scoring.scorePoint(2)
        @expected = [[[5, 7], [0, 0]], [0, 0]]
    end

    # tiebreak
    def test_tiebreak
        @scoring.setScore([40, :adv], [[6, 5]])
        actual = @scoring.scorePoint(2)
        expected = [[[6, 6]], [0, 0]]

        assert_equal expected, actual
        assert @scoring.tiebreak?

        @scoring.setScore([6, 5])
        actual = @scoring.scorePoint(1)
        expected = [[[7, 6], [0, 0]], [0, 0]]

        assert_equal expected, actual
        refute @scoring.tiebreak?
    end

    # match
    def test_win_match_best_of_three
        @scoring.setScore([:adv, 40], [[6, 0],[0, 6], [5, 0]])
        @actual = @scoring.scorePoint(1)
        @expected = [[6, 0],[0, 6], [6, 0]]

        assert @scoring.over?
        assert_equal 1, @scoring.winner
    end

    def test_win_match_on_tiebreak
        @scoring.setScore([:adv, 40], [[6, 4], [6, 4], [5, 6]])
        actual = @scoring.scorePoint(1)
        expected = [[[6, 4], [6, 4], [6, 6]], [0, 0]]

        assert_equal expected, actual
        assert @scoring.tiebreak?

        @scoring.setScore([6, 5])
        actual = @scoring.scorePoint(1)
        expected = [[6, 4], [6, 4], [7, 6]]

        assert_equal expected, actual
        refute @scoring.tiebreak?
        assert @scoring.over?
        assert_equal 1, @scoring.winner
    end
end
