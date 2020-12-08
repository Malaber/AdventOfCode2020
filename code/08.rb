require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

original_instructions = []

lines.each do |line|
  cmd, value = line.split(" ")
  instruction = Instruction.new(cmd, value.to_i, false)
  original_instructions << instruction
end

computer = Computer.new(original_instructions)

begin
  computer.run!
rescue Exception => e
  print e
end

