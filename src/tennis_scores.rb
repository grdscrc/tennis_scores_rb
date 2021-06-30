class TennisScores
    attr_reader :game, :sets, :tiebreak
    alias_method :tiebreak?, :tiebreak

    def initialize
        @game = [0, 0]
        @sets = [[0, 0]]
        @tiebreak = false
    end

    def setScore(game, sets = @sets)
        @game = game
        @sets = sets
    end

    def scorePoint(player)
        winner_index = player - 1
        loser_index = (winner_index + 1) % 2
        gameScore = @game[winner_index]
        gameScoreOpp = @game[loser_index]

        if gameScore == :adv || gameScore == 40 && ![40, :adv].include?(gameScoreOpp)
            @sets.last[winner_index] += 1
            if @sets.last[winner_index] - @sets.last[loser_index] >= 2  # 2 games ahead
                if @sets.last[winner_index] >= 6
                    @sets.push([0,0])
                end
            end
            if [@sets.last[winner_index], @sets.last[loser_index]] == [6, 6]
                @tiebreak = true
            end
            @game = [0, 0]
        else
            @game[winner_index] = nextScore(@game[winner_index])
            if gameScoreOpp == :adv
                @game[loser_index] = 40
            end
        end

        [*@sets, @game]
    end

    def nextScore(score)
        case score
        when 0
            15
        when 15
            30
        when 30
            40
        when 40
            :adv
        end
    end
end
