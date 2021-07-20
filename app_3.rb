require 'bundler'
require 'pry'
require_relative 'lib/game'
require_relative 'lib/player'

Bundler.require

puts File.read("bienvenue.txt")

puts "Ton nom ?"
print " >>"
nom = gets.chomp
puts "Alors #{nom}, contre combien de robots veux-tu jouer ?"
print " >>"
nb_bots = gets.chomp.to_i

fortnite_4 = Game.new(nom,nb_bots)

while fortnite_4.is_still_ongoing? do
    fortnite_4.menuchoice(fortnite_4.menu)
    fortnite_4.enemies_attack
end
puts fortnite_4.end