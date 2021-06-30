class TennisScores
    attr_accessor :game, :sets

    def initialize
        @game = [0, 0]
        @sets = [[0, 0]]
        self
    end

    def scorePoint(player)
        winner_index = player - 1
        loser_index = (winner_index + 1) % 2
        gameScore = @game[winner_index]
        gameScoreOpp = @game[loser_index]

        if gameScore == :adv
            if @sets.last.max < 6
                @sets.last[winner_index] += 1
            elsif @sets.last.min < 5 # 2 games ahead
            elsif @sets.last.min == @sets.last.max - 2
            else
            end
        elsif gameScoreOpp == :adv
            @game = [40, 40]
        else
            @game[winner_index] = nextScore(@game[winner_index])
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
