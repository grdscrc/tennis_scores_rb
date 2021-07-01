class TennisScores
    attr_reader :game, :sets, :tiebreak, :winner
    attr_accessor :over
    alias_method :tiebreak?, :tiebreak
    alias_method :over?, :over

    def initialize
        @game = [0, 0]
        @sets = [[0, 0]]
        @tiebreak = false
        @over = false
    end

    def setScore(game, sets = @sets)
        @game = game
        @sets = sets
    end

    def scorePoint(player)
        return scorePointTiebreak(player) if @tiebreak

        winner_index = player - 1
        loser_index = 1 - winner_index

        if @game[winner_index] == :Av || @game[winner_index] == 40 && ![40, :Av].include?(@game[loser_index])
            scoreSet(winner_index, loser_index)

            return @sets if @over
            
            if [@sets.last[winner_index], @sets.last[loser_index]] == [6, 6]
                @tiebreak = true
            end

            @game = [0, 0]
        else
            @game[winner_index] = nextScore(@game[winner_index])
            if @game[loser_index] == :Av
                @game[loser_index] = 40
            end
        end

        [@sets, @game]
    end

    def scorePointTiebreak(player)
        winner_index = player - 1
        loser_index = 1 - winner_index

        @game[winner_index] += 1
        if @game[winner_index] >= [7, @game[loser_index] + 2].max
            scoreSet(winner_index, loser_index)
            @tiebreak = false

            return @sets if @over

            @game = [0, 0]
        end

        [@sets, @game]
    end

    def scoreSet(winner_index, loser_index)
        @sets.last[winner_index] += 1

        winning_set = @sets.last[winner_index] >= [6, @sets.last[loser_index] + 2].max
        winning_set_tb = @tiebreak && @sets.last[winner_index] == 7

        if winning_set || winning_set_tb
            sets_won = @sets.count do |set|
                set[winner_index] > set[loser_index]
            end
            if @sets.length == 3 && sets_won >= 2
                @over = true
                @winner = winner_index + 1
            end

            @sets.push([0,0]) unless @over
        end
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
            :Av
        end
    end

    def display
        display = ''

        if @over
            display << " P L A Y E R #{@winner} \n"
            display << " W I N S \n"
            display << "P1: #{@sets.map{|s| s[0]}.join('|')}\n"
            display << "P2: #{@sets.map{|s| s[1]}.join('|')}"
        else
            display << " T I E B R E A K \n" if @tiebreak
            display << "P1: #{@sets.map{|s| s[0]}.join('|')} -  #{@game[0]}\n"
            display << "P2: #{@sets.map{|s| s[1]}.join('|')} -  #{@game[1]}"
        end
    end
end
