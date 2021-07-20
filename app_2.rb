require 'bundler'
require 'pry'
require_relative 'lib/game'
require_relative 'lib/player'

Bundler.require

puts File.read("bienvenue.txt")

victoire_human = 0
victoire_robot = 0

puts "Quel est ton prénom, humain ?"
print " >>"

player_human = HumanPlayer.new(gets.chomp)

player1 = Player.new('Fred')
player2 = Player.new('Monica')

bots_array = [player1,player2]

while player_human.is_alive? && (player1.is_alive? || player2.is_alive?)
    choice = player_human.user_choice(bots_array)
    # bots_array.length > 1 ? bot_attacked = bots_array[rand 0..1] : bot_attacked = bots_array[0]
    # player_human.attacks(bot_attacked)
    # bot_attacked.show_state
    # if player1.is_alive? || player2.is_alive?
    if bots_array.length > 0
        puts "La riposte ne se fait pas attendre..."
        bots_array.each do |bot|
            if bot.life_points <= 0 
                bots_array.delete(bot)
            else
                bot.attacks(player_human)
                sleep(2)
                player_human.show_state
            end
        end 
    end
    10.times do
        print "."
        sleep(0.2)
    end
end

if player_human.is_alive? 
    puts "L'humanité gagne !"
else 
    puts "Les robots gagnent... ça sent pas bon !"
end

# binding.pry
# puts "victoire_robot: #{victoire_robot} : #{(victoire_robot/500.00 * 100).ceil(2)}% de victoire "
# puts "victoire_human: #{victoire_human} : #{(victoire_human/500.00 * 100).ceil(2)}% de victoire "
