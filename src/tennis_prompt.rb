#!/usr/local/bin/ruby -w
require './src/tennis_scores.rb'

scoring = TennisScores.new

prompt = "> "
puts "[1] Player one scores [2] Player two scores"
print prompt

while scoring_player = gets.chomp.to_i # loop while getting user input
    if scoring_player > 2 || scoring_player < 1
        puts "Please input a player number"
    else
        score = scoring.scorePoint(scoring_player)

        puts scoring.display
    end
    print prompt
end
