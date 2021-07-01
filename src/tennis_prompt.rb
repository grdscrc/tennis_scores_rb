#!/usr/local/bin/ruby -w
require './src/tennis_scores.rb'

scoring = TennisScores.new

prompt = "> "
puts "[1] Player one scores / [2] Player two scores / [exit]"
print prompt

loop do
    while (input = gets.chomp) && !scoring.over?
        break if input == 'exit'
        scoring_player = input.to_i
        if scoring_player > 2 || scoring_player < 1
            puts "Please input a player number"
        else
            scoring.scorePoint(scoring_player)

            puts scoring.display
        end
        print prompt
    end

    break if input == 'exit'
    puts "[restart] / [exit]"
    print prompt
    input = gets.chomp
    break if input == 'exit'
end