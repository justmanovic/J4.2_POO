require 'bundler'
require 'pry'
require_relative 'lib/game_ameliorations'
require_relative 'lib/player'

Bundler.require

###### POURQUOI les joueurs humains commencent avec 15pv alors qu'ils sont initialisés à 100 ?
# Quelle condition mettre dans new_players_in_sight pour qu'il n'ajoute pas d'adversaires
# après 10 ??
### faut il faire qq chose avec player left quand 1 bot est killed?


puts File.read("bienvenue.txt")

puts "Ton nom ?"
print " >>"
nom = gets.chomp

fortnite_4 = Game.new(nom)

while fortnite_4.is_still_ongoing? do
    fortnite_4.new_players_in_sight
    fortnite_4.menuchoice(fortnite_4.menu)
    fortnite_4.enemies_attack
end
puts fortnite_4.end