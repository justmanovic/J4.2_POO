require 'pry'

class Player
    attr_accessor :name, :life_points
    @@player_all = []

    def initialize(name_to_save)
        @name = name_to_save
        @life_points = 15
        @@player_all << self
    end

    def show_state
        @life_points > 0 ? "> #{@name} a #{@life_points} pv (show state) !" : "#{@name} est DCD"
    end

    def gets_damage(damage)
        @life_points -= damage
        if @life_points <= 0 
            @life_points = 0
            puts "Le joueur #{@name} est deaaad !!! RIP !"
        end
    end

    def attacks(opponent)
        puts
        puts "*********** A L'ATTAQUE ************"
        puts "Le joueur #{@name} attaque le joueur #{opponent.name}"
        damage = compute_damage
        puts "Il inflige à #{opponent.name} #{damage} points de dommage "
        opponent.gets_damage(damage)
        if opponent.life_points > 0
            puts "Il reste donc à #{opponent.name} un total de #{opponent.life_points} pv"
        else puts "#{opponent.name} tombe à 0... GAME OVER"
        end
        puts "*********** Attaque terminée ************"
        puts
    end

    def self.score_final(p1,p2)
        puts "La partie se termine sur un score de #{p1.life_points} (#{p1.name}) à #{p2.life_points} (#{p2.name})"
    end

    def compute_damage
        return rand(1..6)
    end
    
    def is_alive?
        return @life_points>0
    end

    def is_dead?
        return !is_alive?
    end

    def self.all
        return @@player_all
    end

    
end

class HumanPlayer < Player
    attr_accessor :weapon_level

    def initialize(name_to_save)
        @life_points = 100
        @weapon_level = 1

        super(name_to_save)
    end

    def compute_damage
        rand(1..6) * @weapon_level
    end

    def search_weapon
        de = rand(1..6)
        puts "Tu as trouvé une nouvelle arme de niveau #{de}"
        if de > @weapon_level
            @weapon_level = de
            puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
        else
            puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
        end
    end

    def search_health_pack
        de = rand(1..6)
        if de == 1
        puts "Tu n'as rien trouvé... DOMMAGE !"
        elsif de > 1 && de < 6
            puts "Nice, tu as gagné 50 pv"
            @life_points += 50
            @life_points > 100 ? @life_points = 100 : @life_points
            puts "Tu as donc maintenant #{@life_points} pv"
        else
            puts "Nice, tu as gagné 80 pv"
            @life_points += 80
            @life_points > 100 ? @life_points = 100 : @life_points
            puts "Tu as donc maintenant #{@life_points} pv"
        end
    end

    def user_choice(enemies_array)
        puts "Quelle action veux-tu effectuer ?\na - chercher une meilleure arme\ns - chercher à se soigner\nattaquer un joueur en vue :\n"
        enemies_array.each do |bot|
            puts "#{enemies_array.index(bot)} - #{bot.name} a #{bot.life_points} pv"
        end
        print " >>"
        choice = gets.chomp
        (!"as01".include? choice) ? choice_ok = 0 : choice_ok = 1

        while choice_ok == 0
            puts "vous devez choisir entre a, s, 0 ou 1"
            print " >>"
            choice = gets.chomp
            (!"as01".include? choice) ? choice_ok = 0 : choice_ok = 1  
        end

        if choice == "a"
            self.search_weapon
            # puts "Vous avez choisi de chercher une nouvelle arme..."
        elsif choice == "s"
            self.search_health_pack
            puts "Vous avez opté pour un Health pack..."
        elsif choice.to_i < enemies_array.length
            self.attacks(enemies_array[choice.to_i])
            puts "Vous choisissez d'attaquer #{enemies_array[choice.to_i].name}..."
            puts "#{enemies_array[choice.to_i].show_state}"  
        end
    end
end

# binding.pry