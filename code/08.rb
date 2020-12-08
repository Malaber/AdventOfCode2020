require_relative '../input'
require_relative 'handheld/Instruction'
lines = get_lines $PROGRAM_NAME

running = true
acc = 0
pointer = 0
instructions = []

lines.each do |line|
  cmd, value = line.split(" ")
  instruction = Instruction.new(cmd, value.to_i, false)
  instructions << instruction
end

while running
  instruction = instructions[pointer]

  if instruction.nil?
    raise(Exception.new("Out of Bounds"))
  end

  pointer, acc = instruction.run!(pointer, acc)
end