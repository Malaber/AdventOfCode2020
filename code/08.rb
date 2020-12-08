require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

instructions = []

lines.each do |line|
  cmd, value = line.split(" ")
  instruction = Instruction.new(cmd, value.to_i, false)
  instructions << instruction
end

computer = Computer.new(instructions)

computer.run!
