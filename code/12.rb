require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
require_relative 'ship/Move'

lines = get_lines $PROGRAM_NAME

$lookup = %w[N E S W]

n, e, dir = 0, 0, $lookup.index("E") * 90

lines.each do |line|
  move = Move.new(line)
  n, e, dir = move.move(n, e, dir)
end

p n.abs+e.abs
