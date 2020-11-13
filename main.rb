STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.
require_relative 'helper'

class Array

  def mul(factors)
    sum =0
    for i in 0..self.length-1
      sum += self[i] * factors[i]
    end
    sum
  end

end


class Player
  attr_accessor :inv, :score
  attr_accessor :brew_recipes, :spells
end

class Recipe
  attr_accessor :aid, :atype, :ingreds, :price, :tome_index, :tax_count, :castable, :repeatable 
  attr_accessor :total_worth
end

class Game
    attr_accessor :players, :recipes, :testing
    
    def initialize()
      @factors = [10.0, 20.0, 30.0, 40.0]
    end
    
    def  parse_input_data
      
        @players =[]
        @recipes=[]
        
        action_count = gets.to_i
        action_count.times do |idx|
          action_id, action_type, d0, d1, d2, d3, price, tome_index, tax_count, castable, repeatable = gets.split(" ")
          r = Recipe.new
          r.aid = action_id.to_i
          r.atype = action_type
          r.ingreds = [d0, d1, d2, d3].map{|x| x.to_i}

          r.price = price.to_i
          r.tome_index = tome_index.to_i
          r.tax_count = tax_count.to_i
          r.castable = castable.to_i == 1
          r.repeatable = repeatable.to_i == 1
          @recipes << r
        end
    
        2.times do |idx|
            # inv_0: tier-0 ingredients in inventory
            # score: amount of rupees
            inv_0, inv_1, inv_2, inv_3, score = gets.split(" ").collect { |x| x.to_i }
            pl = Player.new
            pl.inv = [inv_0,inv_1,inv_2,inv_3]
            pl.score = score
            @players << pl
        end
    end
  
    def parse_input_data_and_init_some_variables
      @my = @players[0]
      @brew_recipes = @recipes.select{|s| s.atype =="BREW"}

      @my.spells = @recipes.select{|s| s.atype =="CAST"}
      @opp = @players[1]
      @opp.spells = @recipes.select{|s| s.atype =="OPPONENT_CAST"}
    end

  def run
    round=0
    loop do
      round+=1
      break if round>2

      @testing ? parse_data_f : parse_input_data

      parse_input_data_and_init_some_variables

      printf("----players info #{round}
        my inventory #{@my.inv}
        opp inventory #{@opp.inv}\n") if @testing
  

      rr = find_match_recipes
      best = select_best_recipe(rr)
      if best 
        printf("BREW #{best.aid}\n")
      else
        printf("WAIT \n")
      end

    end
  end

  def can_use_recipe(a,b)
    a[0] >= -b[0] && a[1] >= -b[1] && a[2] >= -b[2] && a[3] >= -b[3]
  end
  

  
  def find_match_recipes
    inv = @my.inv
    p player_factor = @my.inv.mul(@factors)

    @brew_recipes.each do |rr|
      rr.total_worth = -rr.ingreds.mul(@factors)/player_factor * rr.price
    end

    sorted = @brew_recipes.sort_by{|x| x.total_worth}
    p sorted.map{|rr| [rr.aid,rr.ingreds, rr.total_worth]}
    
    matched = sorted.select { |rr| can_use_recipe(inv,rr.ingreds) }
  end

  def select_best_recipe(matched)
    matched.first
  end

end

g = Game.new
g.testing = true
g.run