require_relative '../input'
lines = get_lines $PROGRAM_NAME

bag_rules = []
shiny_gold_bag = nil
can_contain_golden_bag = []

class Bag
  attr_accessor :color, :inside_bags

  def initialize(color, inside_bags)
    @color = color
    @inside_bags = inside_bags
  end
end

lines.each do |line|
  # light red bags contain 1 bright white bag, 2 muted yellow bags.
  bag_color, inside_bags = line.split(" bags contain ")

  # 1 bright white bag, 2 muted yellow bags.
  inside_bags = inside_bags.strip.gsub(".", "").split(", ").map{|bag| amount = bag[/\d+/]; inside_bag_color = bag[/[a-z]+ [a-z]+/]; {amount: amount, inside_bag_color: inside_bag_color}}

  bag = Bag.new(bag_color, inside_bags)
  bag_rules << bag

  shiny_gold_bag = bag if bag.color == "shiny gold"
end

def contains_golden_bag(bag, bag_rules, can_contain_golden_bag)
  can_contain_golden_bag << bag unless bag.color == "shiny gold"
  bag_color = bag.color
  bag_rules.each do |rule|
    rule.inside_bags.each do |inside_bag|
      if inside_bag[:inside_bag_color] == bag_color
        can_contain_golden_bag << rule
        contains_golden_bag(rule, bag_rules, can_contain_golden_bag)
      end
    end
  end
end

contains_golden_bag(shiny_gold_bag, bag_rules, can_contain_golden_bag)

p can_contain_golden_bag.map{|b|b.color}.uniq.count

def how_many_bags_are_in_the_bag(bag, bag_rules)
  inside = 0
  bag_itself = 1
  inside_bags = bag.inside_bags
  inside_bags.each do |inside_bag|
    unless inside_bag[:amount].nil?
      inside_bag_from_rules = bag_rules.find{|r| r.color == inside_bag[:inside_bag_color] }
      inside += (inside_bag[:amount].to_i * how_many_bags_are_in_the_bag(inside_bag_from_rules, bag_rules))
    end
  end
  return inside + bag_itself
end

p how_many_bags_are_in_the_bag(shiny_gold_bag, bag_rules) - 1
