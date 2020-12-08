require_relative 'Instruction'
require_relative 'Exceptions'
class Computer
  attr_accessor :instructions, :correct_exit_code

  def initialize(instructions, name)
    @instructions = get_instructions_from_lines(instructions)
    @correct_exit_code = instructions.size
    @name = name
  end

  def run!
    if @name == "Changed index 2 from jmp to nop"
      puts
    end

    running = true
    acc = 0
    pointer = 0

    while running
      instruction = @instructions[pointer]

      if instruction.nil?
        return 0 if pointer == @correct_exit_code

        raise(ComputerError.new("Out of Bounds"))
      end

      begin
        pointer, acc = instruction.run!(pointer, acc)
      rescue ComputerError => e
        raise(ComputerError.new("Computer '#{@name}' failed with '#{e}'\n"))
      end
    end
  end

  def get_instructions_from_lines(lines)
    instructions = []

    lines.each do |line|
      cmd, value = line.split(" ")
      instruction = Instruction.new(cmd, value.to_i)
      instructions << instruction
    end
    return instructions
  end
end