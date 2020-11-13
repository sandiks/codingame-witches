class Array
  def mul(factors)
    sum = 0
    (0..length - 1).each do |i|
      sum += self[i] * factors[i]
    end
    sum
  end
end

class Player
  attr_accessor :inv, :score, :brew_recipes, :spells
end

class Recipe
  attr_accessor :aid, :atype, :ingreds, :price, :tome_index, :tax_count, :castable, :repeatable, :total_worth
end

def parse_input_data
  @players = []
  @recipes = []

  action_count = gets.to_i
  action_count.times do |_idx|
    action_id, action_type, d0, d1, d2, d3, price, tome_index, tax_count, castable, repeatable = gets.split(' ')
    r = Recipe.new
    r.aid = action_id.to_i
    r.atype = action_type
    r.ingreds = [d0, d1, d2, d3].map { |x| x.to_i }

    r.price = price.to_i
    r.tome_index = tome_index.to_i
    r.tax_count = tax_count.to_i
    r.castable = castable.to_i == 1
    r.repeatable = repeatable.to_i == 1
    @recipes << r
  end

  2.times do |_idx|
    # inv_0: tier-0 ingredients in inventory
    # score: amount of rupees
    inv_0, inv_1, inv_2, inv_3, score = gets.split(' ').collect { |x| x.to_i }
    pl = Player.new
    pl.inv = [inv_0, inv_1, inv_2, inv_3]
    pl.score = score
    @players << pl
  end
end

def parse_data_f
  lines = File.readlines('data_test.txt')

  @players = []
  @recipes = []

  action_count = lines[0].to_i
  action_count.times do |idx|
    action_id, action_type, d0, d1, d2, d3, price, tome_index, tax_count, castable, repeatable = lines[idx + 1].split(' ')
    r = Recipe.new
    r.aid = action_id.to_i
    r.atype = action_type
    r.ingreds = [d0, d1, d2, d3].map { |x| x.to_i }

    r.price = price.to_i
    r.tome_index = tome_index.to_i
    r.tax_count = tax_count.to_i
    r.castable = castable.to_i == 1
    r.repeatable = repeatable.to_i == 1
    r.total_worth = r.ingreds.mul([10.0, 20.0, 30.0, 40.0])
    @recipes << r
  end

  2.times do |idx|
    # inv_0: tier-0 ingredients in inventory
    # score: amount of rupees
    inv_0, inv_1, inv_2, inv_3, score = lines[idx + action_count + 1].split(' ').collect { |x| x.to_i }
    p = Player.new
    p.inv = [inv_0, inv_1, inv_2, inv_3]
    p.score = score
    @players << p
  end
end
