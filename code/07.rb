require_relative '../input'
lines = get_lines $PROGRAM_NAME

rules = []
golden_shiny_bag = nil
can_contain_golden_bag = []

lines.each do |line|
  # light red bags contain 1 bright white bag, 2 muted yellow bags.
  bag_color, inside_bags = line.split(" bags contain ")

  # 1 bright white bag, 2 muted yellow bags.
  inside_bags = inside_bags.strip.gsub(".", "").split(", ").map{|bag| amount = bag[/\d+/]; {amount: amount, bag_color: bag.gsub(/\d+ /, "").gsub(/ bags/, "").gsub(/ bag/, "")}}

  bag = {bag_color: bag_color, inside_bags: inside_bags}
  rules << bag

  golden_shiny_bag = bag if bag[:bag_color] == "shiny gold"
end

def contains_golden_bag(bag, rules, can_contain_golden_bag)
  can_contain_golden_bag << bag unless bag[:bag_color] == "shiny gold"
  bag_color = bag[:bag_color]
  rules.each do |rule|
    rule[:inside_bags].each do |inside_bag|
      if inside_bag[:bag_color] == bag_color
        can_contain_golden_bag << rule
        contains_golden_bag(rule, rules, can_contain_golden_bag)
      end
    end
  end
end

contains_golden_bag(golden_shiny_bag, rules, can_contain_golden_bag)

p can_contain_golden_bag.map{|b|b[:bag_color]}.uniq.count

def how_many_bags_are_in_the_bag(bag, rules)
  inside = 0
  bag_itself = 1
  inside_bags = bag[:inside_bags]
  inside_bags.each do |inside_bag|
    unless inside_bag[:amount].nil?
      inside_bag_from_rules = rules.find{|r| r[:bag_color] == inside_bag[:bag_color] }
      inside += (inside_bag[:amount].to_i * how_many_bags_are_in_the_bag(inside_bag_from_rules, rules))
    end
  end
  return inside + bag_itself
end

p how_many_bags_are_in_the_bag(golden_shiny_bag, rules) - 1
