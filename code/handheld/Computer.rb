require_relative 'Instruction'

class Computer
  attr_accessor :instructions, :correct_exit_code

  def initialize(instructions)
    @instructions = instructions
    @correct_exit_code = instructions.size
  end

  def run!
    running = true
    acc = 0
    pointer = 0

    while running
      instruction = @instructions[pointer]

      if instruction.nil?
        return 0 if pointer == @correct_exit_code

        raise(Exception.new("Out of Bounds"))
      end

      pointer, acc = instruction.run!(pointer, acc)
    end
  end
end