require_relative '../input'
lines = get_lines $PROGRAM_NAME

minsize = lines.size * 4 #3 would probably be enough, but I am generous

duplication = minsize / lines.first.strip.size

lines.map! do |line|
  line.strip * duplication
end

x = 0
counter = 0

lines.each do |line|
  counter += 1 if line[x] == "#"
  x += 3
end

puts counter
