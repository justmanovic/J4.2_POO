require_relative 'player'
require 'pry'

class Game
    attr_accessor :human_player, :enemies_in_sight, :player_left

    def initialize(human_name_to_save)
        @human_player = HumanPlayer.new(human_name_to_save)
        @enemies_in_sight = []
        @player_left = 10
    end

    def kill_player(player)
        @enemies_in_sight = @enemies_in_sight - [player]
    end

    def is_still_ongoing?
        @human_player.is_alive? && @player_left > 0
    end

    def new_players_in_sight
        puts "Tous les joueurs sont en vue" if @enemies_in_sight.length == player_left

        nb_new = [0,1,1,1,2,2]
        de = rand 1..6

        # if (@enemies_in_sight.length + player_left) <= 10
        nb_new[de-1].times do
            @enemies_in_sight << Player.new("player-#{(rand 1..9999)}")
        end
        # end
    
        nb_new[de-1] > 0 ? (puts "#{nb_new[de-1]} nouveau(x) joueur(s) arrive(nt)") : (puts "Aucun nouveau joueur n'arrive")
        
    end

    def show_players
        puts @human_player.show_state
        @enemies_in_sight.each { |bot| puts bot.show_state }
    end

    def menu
        puts "Quelle action veux-tu effectuer ?\na - chercher une meilleure arme\ns - chercher à se soigner\nattaquer un joueur en vue :\n"
        @enemies_in_sight.each do |bot|
            puts "#{@enemies_in_sight.index(bot)} - #{bot.show_state}"
        end
        print " >>"
        choice = gets.chomp
        return choice
    end

    def menuchoice(choice)
        tab_choice = []
        # choice_max = @enemies_in_sight.length
        @enemies_in_sight.each { |bot| tab_choice << @enemies_in_sight.index(bot).to_s }
        (!(["a","s"] + tab_choice).include?(choice)) ? choice_ok = 0 : choice_ok = 1

        while choice_ok == 0
            puts "vous devez choisir entre a, s, 0 -->> nb de bot moins 1"
            print " >>"
            choice = gets.chomp
            (!(["a","s"] + tab_choice).include?(choice)) ? choice_ok = 0 : choice_ok = 1
        end

        if choice == "a"
            @human_player.search_weapon
        elsif choice == "s"
            @human_player.search_health_pack
        elsif choice.to_i < @enemies_in_sight.length
            @human_player.attacks(@enemies_in_sight[choice.to_i])
            puts "Vous choisissez d'attaquer #{@enemies_in_sight[choice.to_i].name}..."
            puts "#{@enemies_in_sight[choice.to_i].show_state}"
            self.kill_player(@enemies_in_sight[choice.to_i]) if @enemies_in_sight[choice.to_i].is_dead?
        end
    end
    
    def enemies_attack
        @enemies_in_sight.each do |bot|
            bot.attacks(@human_player)
        end
    end

    def end
        @enemies_in_sight.length == 0 ? "Bravo !" : "Loser !!!"
    end

end

# game1 = Game.new("human")

# puts game1.human_player.name




# binding.pry