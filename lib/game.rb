require_relative 'player'
require 'pry'

class Game
    attr_accessor :human_player, :enemies

    def initialize(human_name_to_save, nombre_bots)
        @human_player = HumanPlayer.new(human_name_to_save)
        @enemies = []
        # 4.times { |i| @enemies << Player.new("bot-#{i}") }
        nombre_bots.times do |i|
            @enemies << Player.new("bot-#{i}")
        end
    end

    def kill_player(player)
        @enemies = @enemies - [player]
    end

    def is_still_ongoing?
        @human_player.is_alive? && @enemies.length > 0
    end

    def show_players
        puts @human_player.show_state
        @enemies.each { |bot| puts bot.show_state }
    end

    def menu
        puts "Quelle action veux-tu effectuer ?\na - chercher une meilleure arme\ns - chercher à se soigner\nattaquer un joueur en vue :\n"
        @enemies.each do |bot|
            puts "#{@enemies.index(bot)} - #{bot.show_state}"
        end
        choice = gets.chomp
        return choice
    end

    def menuchoice(choice)
        tab_choice = []
        # choice_max = @enemies.length
        @enemies.each { |bot| tab_choice << @enemies.index(bot).to_s }
        (!(["a","s"] + tab_choice).include?(choice)) ? choice_ok = 0 : choice_ok = 1
        puts 'je suis entré dans menuchoice'

        while choice_ok == 0
            puts "vous devez choisir entre a, s, 0 ou 1"
            print " >>"
            choice = gets.chomp
            (!(["a","s"] + tab_choice).include?(choice)) ? choice_ok = 0 : choice_ok = 1
        end

        puts "étape2"
        puts choice.to_i

        if choice == "a"
            @human_player.search_weapon
        elsif choice == "s"
            @human_player.search_health_pack
        elsif choice.to_i < @enemies.length
            @human_player.attacks(@enemies[choice.to_i])
            puts "Vous choisissez d'attaquer #{@enemies[choice.to_i].name}..."
            puts "#{@enemies[choice.to_i].show_state}"
            self.kill_player(@enemies[choice.to_i]) if @enemies[choice.to_i].is_dead?
        end
        puts "étape3"
    end
    
    def enemies_attack
        @enemies.each do |bot|
            bot.attacks(@human_player)
        end
    end

    def end
        @enemies.length == 0 ? "Bravo !" : "Loser !!!"
    end

end

# game1 = Game.new("human")

# puts game1.human_player.name




# binding.pry