

def  parse_data_f
    lines = File.readlines("data_test.txt")
  
    @players =[]
    @recipes=[]
    
    action_count = lines[0].to_i
    action_count.times do |idx|
      action_id, action_type, d0, d1, d2, d3, price, tome_index, tax_count, castable, repeatable = lines[idx+1].split(" ")
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
        inv_0, inv_1, inv_2, inv_3, score = lines[idx + action_count+1].split(" ").collect { |x| x.to_i }
        p = Player.new
        p.inv = [inv_0,inv_1,inv_2,inv_3]
        p.score = score
        @players << p
    end
  
end
  