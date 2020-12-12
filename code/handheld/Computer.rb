require_relative 'Instruction'
require_relative '../Exceptions'

class Computer
  attr_accessor :instructions, :correct_exit_code, :name

  def initialize(instructions, name)
    @instructions = get_instructions_from_lines(instructions)
    @correct_exit_code = instructions.size
    @name = name
  end

  def run!
    running = true
    acc = 0
    pointer = 0

    while running
      instruction_with_metadata = @instructions[pointer]

      if instruction_with_metadata.nil?
        return 0, acc, pointer if pointer == @correct_exit_code

        raise(ComputerError.new("Out of Bounds"))
      end

      instruction = instruction_with_metadata[:instruction]
      run_times = instruction_with_metadata[:run_times]

      if run_times > 0
        raise(ComputerError.new("Computer '#{@name}' failed with 'Instruction ran twice, pointer: #{pointer}, acc: #{acc}'\n"))
      end

      pointer, acc = instruction.run!(pointer, acc)
      instruction_with_metadata[:run_times] += 1
    end
  end

  def get_instructions_from_lines(lines)
    instructions = []

    lines.each do |line|
      cmd, value = line.split(" ")
      instruction = Instruction.new(cmd, value.to_i)
      instructions << {instruction: instruction, run_times: 0}
    end
    return instructions
  end
end
