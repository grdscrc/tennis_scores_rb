class TennisScores
    attr_accessor :game, :sets

    def init
        game = [0, 0]
        sets = [[0, 0]]
    end

    def scorePoint(player)
        winner = player - 1
        loser = (player - 2) % 2
        gameScore = game[winner]
        gameScoreOpp = game[loser]

        if gameScore == :adv
            if sets.last.max < 6
                sets.last[winner] += 1
            elsif sets.last.min < 5 # 2 games ahead
            elsif sets.last.min == 
            else
            end
        elsif gameScoreOpp == :adv
            game = [40, 40]
        else
            game[winner] = TennisLinguo.nextScore(game[winner])
        end
    end

    def setScore(score)

    end
end

class TennisLinguo
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