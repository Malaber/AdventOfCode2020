require_relative '../Exceptions'

class Instruction
  attr_accessor :cmd, :value, :run_times

  def initialize(cmd, value)
    @cmd = cmd
    @value = value
  end

  def run!(pointer, acc)

    case @cmd
    when "nop"

    when "acc"
      acc += @value
    when "jmp"
      pointer += @value
      return pointer, acc
    else
      raise(ComputerError.new("Unknown Command"))
    end

    pointer += 1

    return pointer, acc
  end
end
