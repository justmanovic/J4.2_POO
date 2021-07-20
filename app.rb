require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
puts "Voici l'état de chaque joueur :"
player1 = Player.new("Josiane")
player2 = Player.new("Jose")

puts player1.show_state
puts player2.show_state
count = 0

while player1.life_points > 0 && player2.life_points > 0
    count +=1
    player1.attacks(player2)
    puts player2.show_state
    puts
    if player2.life_points > 0 
        player2.attacks(player1)
        puts player1.show_state
    end
end

puts puts puts "Il aura fallu #{count} tours pour terminer cette partie"
Player.score_final(player1,player2)

# player1.attacks(player2)
# player2.show_state


# binding.pry