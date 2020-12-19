require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

exit 0

pocket={}
pocket[0]={}

cycle = 0

lines.each_with_index do |line, line_index|
  pocket[0][line_index]={}
  line.strip!
  line.split("").each_with_index do |active, index|
    pocket[0][line_index][index] = active
  end
end

def extend_pocket(pocket)
  #front


  return pocket
end

while cycle < 6
  extend_pocket(pocket)
end
