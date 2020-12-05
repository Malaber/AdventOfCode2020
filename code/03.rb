require_relative '../input'
lines = get_lines $PROGRAM_NAME

minsize = lines.size * 8 #we need mooooore map

duplication = minsize / lines.first.strip.size

lines.map! do |line|
  line.strip * duplication
end

def get_trees(lines, right, down)
  x = 0
  y = 0
  counter = 0

  lines.each_with_index do |line, i|
    y += 1
    next if i % down == 1
    counter += 1 if line[x] == "#"
    x += right
  end

  return counter
end

puts a = get_trees(lines, 1, 1)
puts b = get_trees(lines, 3, 1)
puts c = get_trees(lines, 5, 1)
puts d = get_trees(lines, 7, 1)
puts e = get_trees(lines, 1, 2)

puts a * b * c * d * e
