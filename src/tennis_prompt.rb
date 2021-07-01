#!/usr/local/bin/ruby -w
require './src/tennis_scores.rb'

prompt = "> "

loop do
    puts "[1] Player one scores / [2] Player two scores / [stop] Stop the match"
    print prompt

    scoring = TennisScores.new

    while !scoring.over? && (input = gets.chomp)
        break if input == 'stop'
        scoring_player = input.to_i
        if scoring_player > 2 || scoring_player < 1
            puts "Please input a player number"
        else
            scoring.scorePoint(scoring_player)

            puts scoring.display
        end
        print prompt unless scoring.over?
    end

    puts "[restart] / [exit]"
    print prompt
    input = gets.chomp
    break if input == 'exit'
end