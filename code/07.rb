require_relative '../input'
lines = get_lines $PROGRAM_NAME

rules = []

lines.each do |line|
  # light red bags contain 1 bright white bag, 2 muted yellow bags.
  bag_color, inside_bags = line.split(" bags contain ")

  # 1 bright white bag, 2 muted yellow bags.
  inside_bags = inside_bags.strip.gsub(".", "").split(", ").map{|bag| amount = bag[/\d+/]; {amount: amount, bag_color: bag.gsub(/\d+ /, "").gsub(/ bags/, "").gsub(/ bag/, "")}}

  bag = {bag_color: bag_color, inside_bags: inside_bags}
  bag >> rules
end

bagtree = rules.map do |rule|

end