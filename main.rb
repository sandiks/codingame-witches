STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.
require_relative 'helper'

class Player
  attr_accessor :inv, :score
end
class Recipe
  attr_accessor :aid, :atype, :ingreds, :price, :tome_index, :tax_count, :castable, :repeatable 
  attr_accessor :total_ingreds
end

class Game
    attr_accessor :players, :recipes, :testing
    
    def initialize()
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
          r.ingreds = [d0, d1, d2, d3].map{|x| -x.to_i}

          r.price = price.to_i
          r.tome_index = tome_index.to_i
          r.tax_count = tax_count.to_i
          r.castable = castable.to_i == 1
          r.repeatable = repeatable.to_i == 1
          r.total_ingreds = r.ingreds.sum 
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
      @opp = @players[1]
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

  def one_ge_other(a,b)
    a[0]>=b[0] && a[1]>=b[1] && a[2]>=b[2] && a[3]>=b[3]
  end

  def find_match_recipes
    sorted = @recipes.sort_by(&:price).reverse
    inv = @my.inv
    matched = sorted.select { |rr| one_ge_other(inv,rr.ingreds) }
  end

  def select_best_recipe(matched)
    matched.first
  end

end

g = Game.new
g.testing = false
g.run